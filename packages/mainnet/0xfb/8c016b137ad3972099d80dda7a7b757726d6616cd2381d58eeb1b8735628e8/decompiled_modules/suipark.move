module 0xfb8c016b137ad3972099d80dda7a7b757726d6616cd2381d58eeb1b8735628e8::suipark {
    struct SUIPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARK>(arg0, 6, b"SUIPARK", b"Sui South Park", b"I'm goin' down to South Park gonna have myself a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiparkprofff_0695e3e60f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

