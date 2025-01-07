module 0x57eb143b86bf260acc437c2f7150e78713287d7c748029cfd9dd709fa5188b59::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 6, b"TADPOLE", b"Tadpole on SUI", b"The Mascot of Sui. tadpoleonsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_151256_bf93dddde0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

