module 0x20b9673b907277ce34996203d60a713d7ec2ba58900c42dac1efd394e8b0cc5::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"XRP SUI", b"XRP SUI ECOSYSTEM MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9018d06d814f9be0d282af95772d9312blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

