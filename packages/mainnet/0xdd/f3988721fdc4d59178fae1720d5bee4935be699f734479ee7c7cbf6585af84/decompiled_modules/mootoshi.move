module 0xddf3988721fdc4d59178fae1720d5bee4935be699f734479ee7c7cbf6585af84::mootoshi {
    struct MOOTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOTOSHI>(arg0, 6, b"MOOTOSHI", b"SUI MOOTOSHI", b"Mootoshi, Satoshi's loyal hippo, wandered lost until I found him, bringing joy and adventure home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mootoshi_03b9e230a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

