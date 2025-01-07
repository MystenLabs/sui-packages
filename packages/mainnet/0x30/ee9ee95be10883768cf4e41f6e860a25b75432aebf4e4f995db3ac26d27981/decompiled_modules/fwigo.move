module 0x30ee9ee95be10883768cf4e41f6e860a25b75432aebf4e4f995db3ac26d27981::fwigo {
    struct FWIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWIGO>(arg0, 6, b"Fwigo", b"FWIGA", b"I'm the black frog on SUI called Fwigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_042652_7c11148e8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

