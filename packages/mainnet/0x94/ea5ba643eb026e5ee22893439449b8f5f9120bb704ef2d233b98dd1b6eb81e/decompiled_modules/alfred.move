module 0x94ea5ba643eb026e5ee22893439449b8f5f9120bb704ef2d233b98dd1b6eb81e::alfred {
    struct ALFRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALFRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFRED>(arg0, 6, b"ALFRED", b"Alfred On Sui", x"4c415354205455524e200a0a24414c4652454420495320434f4d494e4720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062208_8780bd722e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALFRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

