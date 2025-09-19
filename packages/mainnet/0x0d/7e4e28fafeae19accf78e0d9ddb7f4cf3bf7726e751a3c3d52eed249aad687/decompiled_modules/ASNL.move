module 0xd7e4e28fafeae19accf78e0d9ddb7f4cf3bf7726e751a3c3d52eed249aad687::ASNL {
    struct ASNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASNL>(arg0, 9, b"arsenal", b"ASNL", b"arsenal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758316048/sui_tokens/vqcxc0dyvuz3ecicxgfy.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ASNL>>(0x2::coin::mint<ASNL>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASNL>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASNL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

