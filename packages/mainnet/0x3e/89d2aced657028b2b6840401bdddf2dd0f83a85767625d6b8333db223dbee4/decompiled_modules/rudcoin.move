module 0x3e89d2aced657028b2b6840401bdddf2dd0f83a85767625d6b8333db223dbee4::rudcoin {
    struct RUDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDCOIN>(arg0, 9, b"RUDCOIN", b"rud", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dd2023dd81d39863c9a2e73e7a7c2df0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUDCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

