module 0x99644544bd961cd885fa60a7a634b807b8b6770fbac27e901723bf4d3236348f::nye {
    struct NYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYE>(arg0, 6, b"NYE", b"NEW YEARS EVE", b"A revolutionary cryptocurrency blending New Years spirit with tomorrows technology. Invest in innovation, celebrate the countdown with digital security and financial freedom. NYE: The future starts now. Get ready to shine in 2025! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mnk_N_Vfp2_400x400_b42e679efc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

