module 0x18661bd992bc333092ac61678f088106e532d18eb147f2d5838098c50490890::tofu {
    struct TOFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOFU>(arg0, 6, b"TOFU", b"TOFU CHAN", x"546f6675206368616e20697320646f67206d656d65206f6e205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3761_a92d88aaab_9f6c7a1e3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

