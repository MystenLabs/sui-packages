module 0x655a1d5655f8ff731f48ce8947825f00907abf22529f3de70ac92d98d0109cb4::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 6, b"PCAT", b"Penguin Cat", x"4e6f20736f6369616c732073656e6420697420746865204d4557206f662073756920616e6420666974732074686520737569206e6172726174697665206973206974206120636174206f722070656e6775696e20692063616e742074656c6c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_697_F7_CBAE_4_C3_1_14cc950ce5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

