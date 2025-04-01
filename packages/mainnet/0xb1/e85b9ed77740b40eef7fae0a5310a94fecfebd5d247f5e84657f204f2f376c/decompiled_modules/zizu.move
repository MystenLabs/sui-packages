module 0xb1e85b9ed77740b40eef7fae0a5310a94fecfebd5d247f5e84657f204f2f376c::zizu {
    struct ZIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIZU>(arg0, 9, b"ZIZU", b"Zizu", b"ZIZU is a token  that combines engaging world-building elements from voxel games and a design-to-earn model, leveraging blockchain technology on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_67eba1b55a5e01.74585277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

