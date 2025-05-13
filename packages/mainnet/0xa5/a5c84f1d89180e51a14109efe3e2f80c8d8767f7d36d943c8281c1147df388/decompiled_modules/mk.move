module 0xa5a5c84f1d89180e51a14109efe3e2f80c8d8767f7d36d943c8281c1147df388::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"Makylee", b"My Meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/55e981bc5502646f495261234f724831blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

