module 0x45c3bd1e670a19099c33e4bdaac52fdab7b29eb7c77a3d41060349a0454787e1::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COIN>(arg0, 9, 0x1::string::utf8(b"LPDAO1"), 0x1::string::utf8(b"GOVEX_LP_TOKEN DAO1"), 0x1::string::utf8(b"Test coin for launchpad E2E testing"), 0x1::string::utf8(b"https://raw.githubusercontent.com/govex-dao/docs/main/govex-icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN>>(0x2::coin_registry::finalize<COIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

