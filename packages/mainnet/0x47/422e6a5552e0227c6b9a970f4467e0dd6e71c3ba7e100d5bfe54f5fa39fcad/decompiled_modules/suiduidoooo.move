module 0x47422e6a5552e0227c6b9a970f4467e0dd6e71c3ba7e100d5bfe54f5fa39fcad::suiduidoooo {
    struct SUIDUIDOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUIDOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUIDOOOO>(arg0, 6, b"SuiduidoooO", b"Sui Doo", b"The animation depicts Sui Doo's life journey from puppyhood to adulthood, showcasing its innocence, curiosity, and playful nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g29kbl_98fe822e14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUIDOOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUIDOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

