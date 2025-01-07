module 0x1250b481904b94c3bbc6375b3a304ad302d63aed001d84a0ed44bece0ebcc186::votw {
    struct VOTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOTW>(arg0, 9, b"VOTW", b"Victor on the way", b"Top 1 token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/50cedf2de8dcf925a7a8d5498005d735blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

