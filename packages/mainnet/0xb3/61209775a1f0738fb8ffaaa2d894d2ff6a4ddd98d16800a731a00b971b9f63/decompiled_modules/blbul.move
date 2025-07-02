module 0xb361209775a1f0738fb8ffaaa2d894d2ff6a4ddd98d16800a731a00b971b9f63::blbul {
    struct BLBUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLBUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLBUL>(arg0, 9, b"BLBUL", b"BLB", b"Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/05d90ca8eccdd186db876c0fe94f399fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLBUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLBUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

