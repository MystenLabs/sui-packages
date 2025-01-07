module 0x58a44e497470338626ee856a716ed285686e1a03f880559cc840f1f7dffe9f36::suiwoman {
    struct SUIWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMAN>(arg0, 9, b"suiwoman", b"Suiwoman", b"Married wif suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWOMAN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

