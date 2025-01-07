module 0xf82fbf4249a3f67baae1cef211a610f9affe7171ac33025de547e1ddd9229b0e::suizzly {
    struct SUIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZLY>(arg0, 6, b"SUIZZLY", b"BLUE SUIZZLY", b"BLUE SUIZZLY A grizzly-polar-bear-hybrid is a rare ursid hybrid that has occurred both in captivity and in the wild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3824_65ea9f2ff1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

