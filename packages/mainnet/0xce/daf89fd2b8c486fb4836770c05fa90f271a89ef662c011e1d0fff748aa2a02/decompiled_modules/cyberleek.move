module 0xcedaf89fd2b8c486fb4836770c05fa90f271a89ef662c011e1d0fff748aa2a02::cyberleek {
    struct CYBERLEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERLEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERLEEK>(arg0, 6, b"CYBERLEEK", b"CYBERLEEKS", b"Fighting for gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1787859068203.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERLEEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERLEEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

