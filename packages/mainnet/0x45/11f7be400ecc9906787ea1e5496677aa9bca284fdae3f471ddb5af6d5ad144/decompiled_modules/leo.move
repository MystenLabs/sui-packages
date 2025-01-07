module 0x4511f7be400ecc9906787ea1e5496677aa9bca284fdae3f471ddb5af6d5ad144::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"Leo", b"Efezf", b"Sondddld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2178374_w1400h1400c1cx700cy350cxt0cyt0cxb1400cyb700_b708a67f4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

