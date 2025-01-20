module 0xd3f7873d89b57627dcd2fa586d690efb8f007372a60a4dc2a860df31856d689d::nnzi {
    struct NNZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNZI>(arg0, 9, b"NNZI", b"Mika Kunze", b"Mika Kunze - NNZI of Kriya", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/754989513d00d55b9a792c4d5bb4369ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

