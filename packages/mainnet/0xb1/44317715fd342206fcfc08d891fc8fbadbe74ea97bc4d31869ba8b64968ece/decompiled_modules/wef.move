module 0xb144317715fd342206fcfc08d891fc8fbadbe74ea97bc4d31869ba8b64968ece::wef {
    struct WEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEF>(arg0, 6, b"WEF", b"Weaselfly", b"weaselfly is a good synergy for both", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8843f680e54c2039bdefde9c832150b7_removebg_preview_e18616dc82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

