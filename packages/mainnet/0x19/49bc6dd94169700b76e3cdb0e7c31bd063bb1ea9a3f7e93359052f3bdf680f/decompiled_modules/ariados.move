module 0x1949bc6dd94169700b76e3cdb0e7c31bd063bb1ea9a3f7e93359052f3bdf680f::ariados {
    struct ARIADOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIADOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIADOS>(arg0, 9, b"ARIADOS", b"Ariadosui", b"For Ariados fans, immerse in Pokemon x  SUI universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48b415b9289f46ffae865d54336105acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARIADOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIADOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

