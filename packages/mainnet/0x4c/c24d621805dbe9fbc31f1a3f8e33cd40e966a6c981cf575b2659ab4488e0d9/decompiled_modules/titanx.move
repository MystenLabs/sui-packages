module 0x4cc24d621805dbe9fbc31f1a3f8e33cd40e966a6c981cf575b2659ab4488e0d9::titanx {
    struct TITANX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANX>(arg0, 9, b"TITANX", b"TITAN X", b"TITANX TITANX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xf19308f923582a6f7c465e5ce7a9dc1bec6665b1.png?size=xl&key=ce1a5b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TITANX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITANX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

