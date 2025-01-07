module 0x91e53a3187781321769bca49bebf9bcc8f98a0aa17221a1346b60d8a23093c74::blobman {
    struct BLOBMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBMAN>(arg0, 6, b"BLOBMAN", b"blonman sui", b"blobman is a very fluid and fun guy, join him and be like blobman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kandinsky_download_1728905865058_bf6fc56152.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

