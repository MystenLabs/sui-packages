module 0xf853c676c9c57aeca7f1d7e74bd57865e12ca799d0335f1199438bd52a19e0b8::dssname {
    struct DSSNAME has drop {
        dummy_field: bool,
    }

    struct DSSSYMBOL10 has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: DSSSYMBOL10,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<DSSNAME>, arg1: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<DSSNAME>(arg0, arg3);
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::create<DSSNAME>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<DSSNAME>(v0);
    }

    fun init(arg0: DSSNAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DSSSYMBOL10{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<DSSNAME>(arg0, 9, b"DSSSYMBOL10", b"DSSname", b"This is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"link to an image")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSSNAME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSSNAME>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::referrals::ReferralTable, arg5: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection_storage::State, arg6: &0x2::coin::TreasuryCap<DSSNAME>, arg7: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 4 == 3 && false || true;
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::create<DSSSYMBOL10>(v1, arg1, 1000000, 10000, v2, v3, 500, 12312, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

