module 0x9eab2fd1909e0313c945ad3faeef6504cc266383e94ca19fa882d01653bb3bab::marcel {
    struct MARCEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCEL>(arg0, 6, b"MARCEL", b"MARCEL THE SHELL WITH SUIS ON", b"Marcel The Shell With Suis On!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0860_187613f2f5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARCEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

