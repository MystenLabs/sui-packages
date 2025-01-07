module 0x137772918c117b4dddb319572ba808342ba8f4ca124cb4a250e870fa01dad841::scubadog {
    struct SCUBADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBADOG>(arg0, 6, b"SCUBADOG", b"SCUBA DOG", x"455645525920434841494e204e45454420444f47202c20534355424120444f4720495320535549204d4153434f542e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3832_46e9c23991_cd9394b354.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

