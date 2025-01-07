module 0xae4c73d47c756cb989f6eb5dae385f9687d392df857e12b5d261f246d05bebee::vector {
    struct VECTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VECTOR>(arg0, 6, b"VECTOR", b"Vector cats", b"Vector cats pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-clipart/20220612/ourmid/pngtree-meme-cat-png-image_5002938.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VECTOR>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VECTOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VECTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

