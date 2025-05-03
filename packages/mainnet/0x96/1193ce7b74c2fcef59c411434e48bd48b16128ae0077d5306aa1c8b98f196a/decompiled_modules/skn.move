module 0x961193ce7b74c2fcef59c411434e48bd48b16128ae0077d5306aa1c8b98f196a::skn {
    struct SKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKN>(arg0, 6, b"SKN", b"suikin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

