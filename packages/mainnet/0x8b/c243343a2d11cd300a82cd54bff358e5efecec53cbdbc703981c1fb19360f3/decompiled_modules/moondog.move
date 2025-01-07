module 0x8bc243343a2d11cd300a82cd54bff358e5efecec53cbdbc703981c1fb19360f3::moondog {
    struct MOONDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOG>(arg0, 6, b"MOONDOG", b"MOON DOG SUI", b"Moondog is a big dog with a small dream. Growing up hunting in the vast expanse of the Siberian wilderness, Moondog spent many sleepless nights staring up at the sky.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sk_MMJI_Qs_400x400_7003ecb0c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

