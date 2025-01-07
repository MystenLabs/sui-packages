module 0x645970eeecf1258255770d44204c818789f3061902dd958e2cbaaeb19bd7107d::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 6, b"ANGEL", b"Sui-Angel", b"A decentralized system on Sui blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10771d95_8758_4ad1_b58f_58440d3d7167_000652877a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

