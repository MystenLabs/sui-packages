module 0xf31b69c92b0eef859387396cdf513828561fbfc393d4cd76dd7b8d08a7bf72f7::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"Suishib", b"SUISHIB", b"Suishib is a new generation memecoin that brings the spirit of Shiba to the Sui blockchain in a way youve never seen before! Built for those who dare to dream big and seek excitement in crypto, Suishib is not just about investmentit's an epic adventure in the super-fast Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_14_24_38_3d360fe390.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

