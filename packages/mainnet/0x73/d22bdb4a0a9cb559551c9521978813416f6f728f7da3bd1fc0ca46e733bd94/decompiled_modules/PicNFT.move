module 0x73d22bdb4a0a9cb559551c9521978813416f6f728f7da3bd1fc0ca46e733bd94::PicNFT {
    struct AdminCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct PICNFT has drop {
        dummy_field: bool,
    }

    struct Pic has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        reference: 0x1::string::String,
    }

    struct PicMinted has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        receiver: address,
    }

    entry fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::transfer_policy::TransferPolicy<Pic>, arg4: address, arg5: &mut 0x2::coin::Coin<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 0);
        let (v0, v1) = 0x2::kiosk::purchase<Pic>(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(arg2, arg6, arg7));
        let v2 = v1;
        0x73d22bdb4a0a9cb559551c9521978813416f6f728f7da3bd1fc0ca46e733bd94::rule::pay<Pic, 0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(arg3, &mut v2, arg5, arg4, arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Pic>(arg3, v2);
        0x2::transfer::public_transfer<Pic>(v0, 0x2::tx_context::sender(arg7));
    }

    entry fun create_pic(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.owner == 0x2::tx_context::sender(arg4), 0);
        let v0 = Pic{
            id        : 0x2::object::new(arg4),
            image_url : arg0,
            name      : arg1,
            reference : arg2,
        };
        let v1 = PicMinted{
            id       : 0x2::object::id<Pic>(&v0),
            name     : v0.name,
            receiver : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PicMinted>(v1);
        0x2::transfer::public_transfer<Pic>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Pic>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Pic>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Pic>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PICNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::package::claim_and_keep<PICNFT>(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

