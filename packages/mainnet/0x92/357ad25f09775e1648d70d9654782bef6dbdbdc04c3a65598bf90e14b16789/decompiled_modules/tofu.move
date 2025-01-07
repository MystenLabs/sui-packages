module 0x92357ad25f09775e1648d70d9654782bef6dbdbdc04c3a65598bf90e14b16789::tofu {
    struct TOFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOFU>(arg0, 6, b"TOFU", b"TOFU CHAN", b"Tofu chan is dog meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3761_a92d88aaab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

