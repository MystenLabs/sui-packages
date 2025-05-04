module 0x660e1d84b15a4df28503a4d56ba5ce126fe095e80ef5b598168c1cc639b7737c::next {
    struct NEXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXT>(arg0, 9, b"NEXT", b"the nextchain", b"memecoin pf sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/96be240b1b401e2d07927817965662a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

