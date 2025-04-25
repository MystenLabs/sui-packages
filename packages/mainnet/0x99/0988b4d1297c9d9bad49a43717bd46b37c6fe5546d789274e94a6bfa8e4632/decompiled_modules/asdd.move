module 0x990988b4d1297c9d9bad49a43717bd46b37c6fe5546d789274e94a6bfa8e4632::asdd {
    struct ASDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDD>(arg0, 9, b"ASDD", b"asdfasd", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

