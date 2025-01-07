module 0x72e59fabd58f34ca38c3d72657c62f3fd54889565ff323e56300879f92a58::hams {
    struct HAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMS>(arg0, 6, b"HAMS", b"Hamsters Sui", b"The Hamsters Sui has a unique design and was created by Sui blockchain enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5829174967942_fbcb2654175eac66e690ca4dd8afeeb6_f37a73a5b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

