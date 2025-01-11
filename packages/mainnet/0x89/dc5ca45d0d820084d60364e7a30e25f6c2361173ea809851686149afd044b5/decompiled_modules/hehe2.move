module 0x89dc5ca45d0d820084d60364e7a30e25f6c2361173ea809851686149afd044b5::hehe2 {
    struct HEHE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE2>(arg0, 9, b"HEHE3", b"HEHE3", b"Hehehehehehehehehehehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzqBvzdVf-9AKTWLtxFIOKkqPY_K9pOViKMA&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE2>>(v1);
        0x2::coin::mint_and_transfer<HEHE2>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HEHE2>>(v2);
    }

    // decompiled from Move bytecode v6
}

