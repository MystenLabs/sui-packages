module 0xe2622e919975e6a90a782448df7c059b4de1e2a3ad83d4d0e8db68099e11a97b::sfk {
    struct SFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFK>(arg0, 6, b"SFK", b"SUPER SUI FISH KING", b"SUPER SUI FISH KING IS THE KING OF THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14f7c2d6_0c4c_40b6_90fa_639b893bfd2c_35cdf5f0ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

