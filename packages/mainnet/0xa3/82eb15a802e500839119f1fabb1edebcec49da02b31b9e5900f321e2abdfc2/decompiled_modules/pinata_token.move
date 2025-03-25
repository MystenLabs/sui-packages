module 0xa382eb15a802e500839119f1fabb1edebcec49da02b31b9e5900f321e2abdfc2::pinata_token {
    struct PINATA_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA_TOKEN>(arg0, 6, b"COIN", b"COIN", b"COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifrens.com/images/narwhal-about.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA_TOKEN>>(0x2::coin::mint<PINATA_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINATA_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

