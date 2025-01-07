module 0x999dbc9692779a0996490e1f4503056bd6baec8b6183a1d5d6e80bc353d6f505::zela {
    struct ZELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELA>(arg0, 9, b"Zela", b"Zela coin", b"$ZELA coin -The token named after Alexander. Made by the joint forces of Zerebro and Truth-Terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2HxrCzbPo6DfnHSDviNgg7QTsXwQzLdxAUdjGc65pump.png?size=xl&key=f5f716")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZELA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZELA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

