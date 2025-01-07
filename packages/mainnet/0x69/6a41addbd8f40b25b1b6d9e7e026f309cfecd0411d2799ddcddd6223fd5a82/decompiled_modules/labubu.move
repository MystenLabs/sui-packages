module 0x696a41addbd8f40b25b1b6d9e7e026f309cfecd0411d2799ddcddd6223fd5a82::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"LABUBU", b"LABUBU the smiling monster!", b"Labubu is a kind-hearted character who always wants to help out but keeps accidentally doing bad things. Labubu will be the leading monster of SUI ecosystem in 2025.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/labubu01_65df416666.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

