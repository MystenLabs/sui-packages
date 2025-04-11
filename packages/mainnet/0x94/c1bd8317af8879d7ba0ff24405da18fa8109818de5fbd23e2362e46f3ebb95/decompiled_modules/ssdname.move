module 0x94c1bd8317af8879d7ba0ff24405da18fa8109818de5fbd23e2362e46f3ebb95::ssdname {
    struct SSDNAME has drop {
        dummy_field: bool,
    }

    struct AADSYMBOL10 has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: AADSYMBOL10,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<SSDNAME>, arg1: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<SSDNAME>(arg0, arg3);
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::create<SSDNAME>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<SSDNAME>(v0);
    }

    fun init(arg0: SSDNAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AADSYMBOL10{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<SSDNAME>(arg0, 9, b"AADSYMBOL10", b"ssdname", b"This is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"link to an image")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDNAME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSDNAME>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::referrals::ReferralTable, arg5: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection_storage::State, arg6: &0x2::coin::TreasuryCap<SSDNAME>, arg7: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 4 == 3 && false || true;
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::create<AADSYMBOL10>(v1, arg1, 1000000, 10000, v2, v3, 500, 12312, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

