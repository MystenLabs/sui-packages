module 0xce4b98a2b6430a62b8a6f5b09fe2ea5fcb87c7b7a9529908bb126af0facf0ef6::suident {
    struct SUIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENT>(arg0, 6, b"SUIDENT", b"Sui Trident", b"The ultimate weapon of the deep. Wield the power of the Sui seas like a true underwater king.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suident_8aa89d8e5d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

