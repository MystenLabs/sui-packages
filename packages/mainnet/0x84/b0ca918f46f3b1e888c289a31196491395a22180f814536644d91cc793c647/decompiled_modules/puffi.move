module 0x84b0ca918f46f3b1e888c289a31196491395a22180f814536644d91cc793c647::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"Puffi", b"PUFFI ON SUI", b"Blowin Up Like a Balloon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241009_171624_618_d265743052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

