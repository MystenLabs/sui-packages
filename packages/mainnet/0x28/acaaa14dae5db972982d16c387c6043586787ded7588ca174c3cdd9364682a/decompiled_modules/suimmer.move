module 0x28acaaa14dae5db972982d16c387c6043586787ded7588ca174c3cdd9364682a::suimmer {
    struct SUIMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMER>(arg0, 6, b"SUIMMER", b"Suimmer on SUI", b"The Beautiful Suimmer of the Sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1b2c7465_bf83_4084_8597_eb3aaed4db44_fb76307c71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

