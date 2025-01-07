module 0xb712324732d8f65ab63c287db86211c23798504c2966830d38d9f8ccf34c5f39::remilia {
    struct REMILIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIA>(arg0, 6, b"Remilia", b"Remilia Sui", b"for every remilio, there is his Remilia - Muard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4938273283372068259_792411b117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMILIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMILIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

