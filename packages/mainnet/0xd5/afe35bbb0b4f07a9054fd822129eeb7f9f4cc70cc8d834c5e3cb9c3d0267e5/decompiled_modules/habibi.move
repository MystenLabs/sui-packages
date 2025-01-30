module 0xd5afe35bbb0b4f07a9054fd822129eeb7f9f4cc70cc8d834c5e3cb9c3d0267e5::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"Habibi Cat", b"Habibi Cat is the wealthiest Cat alive, there is nothing he can't buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_4_d3e8a8aec0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

