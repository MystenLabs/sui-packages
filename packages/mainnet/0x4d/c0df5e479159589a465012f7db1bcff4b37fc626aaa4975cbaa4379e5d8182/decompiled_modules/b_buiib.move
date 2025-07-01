module 0x4dc0df5e479159589a465012f7db1bcff4b37fc626aaa4975cbaa4379e5d8182::b_buiib {
    struct B_BUIIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BUIIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BUIIB>(arg0, 9, b"bBUIIB", b"bToken BUIIB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BUIIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BUIIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

