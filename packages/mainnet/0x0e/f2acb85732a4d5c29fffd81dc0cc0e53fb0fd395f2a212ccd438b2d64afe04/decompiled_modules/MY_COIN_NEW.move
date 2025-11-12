module 0xef2acb85732a4d5c29fffd81dc0cc0e53fb0fd395f2a212ccd438b2d64afe04::MY_COIN_NEW {
    struct MY_COIN_NEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN_NEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MY_COIN_NEW>(arg0, 6, 0x1::string::utf8(b"MY_COIN2"), 0x1::string::utf8(b"My Coin2"), 0x1::string::utf8(b"Standard Unregulated Coin2"), 0x1::string::utf8(b"https://slerf.tools/img/menu/help.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN_NEW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MY_COIN_NEW>>(0x2::coin_registry::finalize<MY_COIN_NEW>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_self(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN_NEW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN_NEW>>(0x2::coin::mint<MY_COIN_NEW>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_to(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN_NEW>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN_NEW>>(0x2::coin::mint<MY_COIN_NEW>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

