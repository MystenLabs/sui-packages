module 0xc0ddc636ffc2639a71b3bb2da981f1e5ec48a8a69b84d39afbb455e6e9356f0f::aya {
    struct AYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYA>(arg0, 6, b"AYA", b"Ayahuasca on SUI", b"Travel through different planes of existence on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aya_afd6e64d64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

