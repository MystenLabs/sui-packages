module 0xc69bd78adb4e01902638b87a9223261c459e804082064a755c43c9c3eba7395d::pwh {
    struct PWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWH>(arg0, 9, b"PWH", b"Penguwifhat", x"74686520686174207374617973206f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTfoi8Kk4px5G89kwK6569j3E82iGSrJg7ix1ZgjCxd9z")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PWH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

