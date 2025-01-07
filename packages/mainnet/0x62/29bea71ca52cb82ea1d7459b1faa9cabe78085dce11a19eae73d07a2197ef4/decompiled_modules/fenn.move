module 0x6229bea71ca52cb82ea1d7459b1faa9cabe78085dce11a19eae73d07a2197ef4::fenn {
    struct FENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENN>(arg0, 6, b"FENN", b"FENNDY", b"$FENN - Party hard. Trade harder. Get rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_16_44_39_340815e5ce_5ab205abe8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENN>>(v1);
    }

    // decompiled from Move bytecode v6
}

