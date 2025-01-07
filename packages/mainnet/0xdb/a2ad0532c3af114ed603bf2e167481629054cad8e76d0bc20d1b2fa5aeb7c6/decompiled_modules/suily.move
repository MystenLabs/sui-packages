module 0xdba2ad0532c3af114ed603bf2e167481629054cad8e76d0bc20d1b2fa5aeb7c6::suily {
    struct SUILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILY>(arg0, 6, b"SUILY", b"The Sui Seal", b"Hi im SUILY the most badass seal on SUI. Here to take over the sui network with my flips and tricks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_29_19_39_40_5ae12bf61e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

