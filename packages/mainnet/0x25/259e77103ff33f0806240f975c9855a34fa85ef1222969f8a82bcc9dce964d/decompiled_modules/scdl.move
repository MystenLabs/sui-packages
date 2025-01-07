module 0x25259e77103ff33f0806240f975c9855a34fa85ef1222969f8a82bcc9dce964d::scdl {
    struct SCDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCDL>(arg0, 6, b"SCDL", b"SUIcidal Coin", x"54686520636f696e20666f7220646567656e732077686f20617265207469726564206f66207275676765727320616e64206a6565746572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_821265953258944_0ec9ab7870.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

