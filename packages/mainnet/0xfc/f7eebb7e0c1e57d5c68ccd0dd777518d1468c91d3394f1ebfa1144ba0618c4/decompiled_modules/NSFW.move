module 0x26cd4cbeb3e5e6558d66f1b6ffd3e852921790e19af7c79cdbc5992823c2aaef::NSFW {
    struct AdminCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct NSFW has drop {
        dummy_field: bool,
    }

    struct Hentai has store, key {
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

    entry fun take(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Hentai>(0x2::kiosk::take<Hentai>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    entry fun batch_burn(arg0: vector<Hentai>) {
        while (!0x1::vector::is_empty<Hentai>(&arg0)) {
            burn(0x1::vector::pop_back<Hentai>(&mut arg0));
        };
        0x1::vector::destroy_empty<Hentai>(arg0);
    }

    entry fun batch_take<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg0, arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)), 0x2::tx_context::sender(arg3));
        };
    }

    entry fun burn(arg0: Hentai) {
        let Hentai {
            id        : v0,
            image_url : _,
            name      : _,
            reference : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::transfer_policy::TransferPolicy<Hentai>, arg4: address, arg5: &mut 0x2::coin::Coin<0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 0);
        let (v0, v1) = 0x2::kiosk::purchase<Hentai>(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(arg2, arg6, arg7));
        let v2 = v1;
        0x26cd4cbeb3e5e6558d66f1b6ffd3e852921790e19af7c79cdbc5992823c2aaef::rule::pay<Hentai, 0xc7f1f37f32f9c539426e10fa6ff1fd1be45b94573f83f8a72e54cdc7072735be::pui::PUI>(arg3, &mut v2, arg5, arg4, arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Hentai>(arg3, v2);
        0x2::transfer::public_transfer<Hentai>(v0, 0x2::tx_context::sender(arg7));
    }

    entry fun create_pic(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.owner == 0x2::tx_context::sender(arg4), 0);
        let v0 = Hentai{
            id        : 0x2::object::new(arg4),
            image_url : arg0,
            name      : arg1,
            reference : arg2,
        };
        let v1 = PicMinted{
            id       : 0x2::object::id<Hentai>(&v0),
            name     : v0.name,
            receiver : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PicMinted>(v1);
        0x2::transfer::public_transfer<Hentai>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Hentai>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Hentai>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Hentai>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: NSFW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::package::claim_and_keep<NSFW>(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

