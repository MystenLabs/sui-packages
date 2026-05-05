module 0xb59d9390ab8ec988a92d068e8b7f33361478490c495eec29769280a4dd619ff2::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1777997752414-e30a851647c19bba96fb73f9ce495188.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1777997752414-e30a851647c19bba96fb73f9ce495188.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"Memiko", b"Memiko coin  its a project on sui", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<MEM>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEM>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

