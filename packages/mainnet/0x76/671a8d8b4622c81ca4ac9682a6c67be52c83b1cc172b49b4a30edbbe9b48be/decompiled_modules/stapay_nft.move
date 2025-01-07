module 0x76671a8d8b4622c81ca4ac9682a6c67be52c83b1cc172b49b4a30edbbe9b48be::stapay_nft {
    struct STAPAYNFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        amount: u64,
        service: 0x1::string::String,
        third_party_service: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct STAPAY_NFT has drop {
        dummy_field: bool,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct ServiceMintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x1::string::String>>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
        service: 0x1::string::String,
        third_party_service: 0x1::string::String,
        name: 0x1::string::String,
        creator: address,
    }

    struct ServiceMintRecordChanged has copy, drop {
        recipient: address,
        service_mint_record: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    public entry fun burn(arg0: &mut ServiceMintRecord, arg1: STAPAYNFT) {
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.record, arg1.recipient);
        0x2::vec_set::remove<0x1::string::String>(v0, &arg1.service);
        if (0x2::vec_set::is_empty<0x1::string::String>(v0)) {
            0x2::table::remove<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.record, arg1.recipient);
            let v1 = ServiceMintRecordChanged{
                recipient           : arg1.recipient,
                service_mint_record : 0x2::vec_set::empty<0x1::string::String>(),
            };
            0x2::event::emit<ServiceMintRecordChanged>(v1);
        } else {
            let v2 = ServiceMintRecordChanged{
                recipient           : arg1.recipient,
                service_mint_record : *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.record, arg1.recipient),
            };
            0x2::event::emit<ServiceMintRecordChanged>(v2);
        };
        let STAPAYNFT {
            id                  : v3,
            nft_id              : _,
            name                : _,
            amount              : _,
            service             : _,
            third_party_service : _,
            image_url           : _,
            creator             : _,
            recipient           : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    fun init(arg0: STAPAY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"service"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"third_party_service"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{service}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{third_party_service}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for your stapay stake"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = ServiceMintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, 0x2::vec_set::VecSet<0x1::string::String>>(arg1),
        };
        let v5 = 0x2::package::claim<STAPAY_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<STAPAYNFT>(&v5, v0, v2, arg1);
        0x2::display::update_version<STAPAYNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<STAPAYNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ServiceMintRecord>(v4);
    }

    public entry fun mint(arg0: &mut ServiceMintRecord, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.record, arg6)) {
            0x2::vec_set::insert<0x1::string::String>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.record, arg6), arg3);
        } else {
            let v0 = 0x2::vec_set::empty<0x1::string::String>();
            0x2::vec_set::insert<0x1::string::String>(&mut v0, arg3);
            0x2::table::add<address, 0x2::vec_set::VecSet<0x1::string::String>>(&mut arg0.record, arg6, v0);
        };
        let v1 = ServiceMintRecordChanged{
            recipient           : arg6,
            service_mint_record : *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.record, arg6),
        };
        0x2::event::emit<ServiceMintRecordChanged>(v1);
        let v2 = STAPAYNFT{
            id                  : 0x2::object::new(arg7),
            nft_id              : 0x2::table::length<address, 0x2::vec_set::VecSet<0x1::string::String>>(&arg0.record) + 1,
            name                : arg1,
            amount              : arg2,
            service             : arg3,
            third_party_service : arg4,
            image_url           : arg5,
            creator             : 0x2::tx_context::sender(arg7),
            recipient           : arg6,
        };
        let v3 = NFTMinted{
            object_id           : 0x2::object::id<STAPAYNFT>(&v2),
            amount              : arg2,
            service             : arg3,
            third_party_service : arg4,
            name                : arg1,
            creator             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<STAPAYNFT>(v2, arg6);
    }

    // decompiled from Move bytecode v6
}

