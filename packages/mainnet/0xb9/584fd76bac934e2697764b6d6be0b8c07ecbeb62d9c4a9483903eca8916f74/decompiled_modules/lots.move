module 0xb9584fd76bac934e2697764b6d6be0b8c07ecbeb62d9c4a9483903eca8916f74::lots {
    struct LOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTS>(arg0, 6, b"LOTS", b"The Lord of The SUI", b"Don't trust your head, Samwise, it's far from the best you've got!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_2022_11_16_at_2_24_03_PM_2a0dacb8d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

