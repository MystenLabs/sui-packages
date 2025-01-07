module 0x86631ed286a836037b0e67c6fc699baffe839feb305c76c706582cd264aa22e2::tiktok {
    struct TIKTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKTOK>(arg0, 9, b"TikTok", b"TikTok", b"TikTok real token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIKTOK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKTOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIKTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

