module 0x47593ad885341ef57d80702d768291467cdad71911e7d4dcb0e12b9d2d85341f::notnfsw {
    struct NOTNFSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTNFSW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742549572996.webp"));
        let (v1, v2) = 0x2::coin::create_currency<NOTNFSW>(arg0, 6, b"notNFSW", b"notNFSW", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTNFSW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTNFSW>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NOTNFSW>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOTNFSW>>(arg0);
    }

    // decompiled from Move bytecode v6
}

