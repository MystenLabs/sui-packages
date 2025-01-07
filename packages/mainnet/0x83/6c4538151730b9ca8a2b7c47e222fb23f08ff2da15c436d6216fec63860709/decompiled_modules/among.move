module 0x836c4538151730b9ca8a2b7c47e222fb23f08ff2da15c436d6216fec63860709::among {
    struct AMONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONG>(arg0, 6, b"AMONG", b"AmongSUI", x"4865792c2049276d20426c75652066726f6d2022416d6f6e672055732e220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yellow_4afef5552e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

