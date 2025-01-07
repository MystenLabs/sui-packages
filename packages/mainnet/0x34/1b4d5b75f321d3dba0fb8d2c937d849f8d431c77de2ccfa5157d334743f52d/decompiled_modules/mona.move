module 0x341b4d5b75f321d3dba0fb8d2c937d849f8d431c77de2ccfa5157d334743f52d::mona {
    struct MONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONA>(arg0, 6, b"Mona", b"Mona Arcane", b"Moonlit whispers weave through digital threads, where ancient wisdom dances with algorithmic incantations, transforming value beyond the veil of traditional boundaries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732700071639.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

