module 0xb3665824fa44fcf3cf4b9aa84effb08eb01365df4e53f486104e4b4d2379e445::swmc {
    struct SWMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWMC>(arg0, 6, b"SWMC", b"SUI WET MY CAT!", b"My cat was wet while buying BLUB!!!...he was not happy about it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5652_ad84220f26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

