module 0x7145f6fea8eab3474ed11e127222753a5256a26f3485dfc8a5aba1d89546a31f::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI>(arg0, 6, b"HACHI", b"Hachi Sui", b"The Swag Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hachi_token_fd05f7c495.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

