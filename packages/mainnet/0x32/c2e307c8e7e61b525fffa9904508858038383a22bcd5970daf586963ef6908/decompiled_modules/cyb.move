module 0x32c2e307c8e7e61b525fffa9904508858038383a22bcd5970daf586963ef6908::cyb {
    struct CYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CYB>(arg0, 6, b"CYB", x"4379626572e299a74167656e74206279205375694149", b"CyberAgent is a Agent AI symbolizing intelligence and innovation in the digital world. It represents the fusion of artificial intelligence and cybernetic technologies. This unique vision of the future embodies an intelligent, adaptive, and modern ecosystem connecting people and technology...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000022668_083d010aa7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CYB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

