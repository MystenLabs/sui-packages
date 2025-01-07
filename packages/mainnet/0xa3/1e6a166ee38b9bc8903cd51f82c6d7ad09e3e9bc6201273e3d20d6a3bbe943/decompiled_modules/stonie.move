module 0xa31e6a166ee38b9bc8903cd51f82c6d7ad09e3e9bc6201273e3d20d6a3bbe943::stonie {
    struct STONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONIE>(arg0, 6, b"STONIE", b"Sui Stonie", b"Meet Stonie, the highest member of the group. He was so stoned that he missed the invitation to join the Boys' Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stonie_825cc3cf62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

