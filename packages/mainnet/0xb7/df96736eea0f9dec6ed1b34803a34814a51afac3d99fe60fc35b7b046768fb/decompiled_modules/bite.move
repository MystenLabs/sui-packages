module 0xb7df96736eea0f9dec6ed1b34803a34814a51afac3d99fe60fc35b7b046768fb::bite {
    struct BITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITE>(arg0, 6, b"Bite", b"Bite dog", b"Buy or bite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1381728837155_pic_56b2199f70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

