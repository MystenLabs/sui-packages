module 0x11e2894e9630c7858f96513fb8f13920e1fdf1c0cf2a096af406358786cb83e7::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"APE GANG", b"Ape gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735494039716.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

