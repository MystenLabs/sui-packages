module 0x8dd2a3b774b1912614f77181e9b3fcd6fc43ab00946f449d833826bb14f32dea::mmeow {
    struct MMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEOW>(arg0, 9, b"MMEOW", b"mew", b"FUN COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1378802c185a5e9f08ffbd43c33851d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

