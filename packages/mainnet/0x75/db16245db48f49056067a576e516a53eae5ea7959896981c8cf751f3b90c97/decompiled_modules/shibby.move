module 0x75db16245db48f49056067a576e516a53eae5ea7959896981c8cf751f3b90c97::shibby {
    struct SHIBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBBY>(arg0, 6, b"SHIBBY", b"Shibby Coin", b"Introducing Shibby Coin  the next-generation meme token on the Sui Chain blockchain! We're thrilled to have you join our vibrant community as we embark on this exciting journey to the moon and beyond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shibby_7a56c2cbf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

