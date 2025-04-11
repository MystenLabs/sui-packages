module 0x51f18b2972e3eda4d5462acd1b47534d80114ab0af7f8b0369abb78b04fc8714::sui_mainnet_dev22w3qww {
    struct SUI_MAINNET_DEV22W3QWW has drop {
        dummy_field: bool,
    }

    struct SUI_MAINNET_D_EV22_W3_QWWSUI has drop, store {
        dummy_field: bool,
    }

    struct WitnessCap has key {
        id: 0x2::object::UID,
        witness: SUI_MAINNET_D_EV22_W3_QWWSUI,
    }

    fun add_policy(arg0: &0x2::coin::TreasuryCap<SUI_MAINNET_DEV22W3QWW>, arg1: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::new_policy<SUI_MAINNET_DEV22W3QWW>(arg0, arg3);
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::create<SUI_MAINNET_DEV22W3QWW>(arg1, v1, arg2, arg3);
        0x2::token::share_policy<SUI_MAINNET_DEV22W3QWW>(v0);
    }

    fun init(arg0: SUI_MAINNET_DEV22W3QWW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SUI_MAINNET_D_EV22_W3_QWWSUI{dummy_field: false};
        let v1 = WitnessCap{
            id      : 0x2::object::new(arg1),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<SUI_MAINNET_DEV22W3QWW>(arg0, 9, b"SUI_MAINNET_D_EV22_W3_QWWSUI", b"sui_mainnet_dev22w3qww", b"Sui Mainnet DEv desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.nomadcalendar.io/up/nft-collection/nft/67ed22c3d67da08052f1587d/67ed22c3d67da08052f1587c_medium.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_MAINNET_DEV22W3QWW>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_MAINNET_DEV22W3QWW>>(v3);
    }

    entry fun initialize_hub(arg0: WitnessCap, arg1: 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::factory::CollectionCap, arg2: &0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::PublisherWrapper, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::referrals::ReferralTable, arg5: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection_storage::State, arg6: &0x2::coin::TreasuryCap<SUI_MAINNET_DEV22W3QWW>, arg7: &mut 0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::hub_token::HubStorage, arg8: &mut 0x2::tx_context::TxContext) {
        let WitnessCap {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        add_policy(arg6, &arg1, arg7, arg8);
        let v2 = 1 == 1 && false || true;
        let v3 = 3 == 3 && false || true;
        0xfa9049cf59251a7e80ceedd9aaa845333cd2832cfbae776feb2f03547aa40816::collection::create<SUI_MAINNET_D_EV22_W3_QWWSUI>(v1, arg1, 50000, 0, v2, v3, 9999, 1777549380, arg2, arg3, arg4, arg5, arg8);
    }

    // decompiled from Move bytecode v6
}

