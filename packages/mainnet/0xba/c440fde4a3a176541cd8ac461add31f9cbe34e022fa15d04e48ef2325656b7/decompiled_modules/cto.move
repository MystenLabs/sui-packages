module 0xbac440fde4a3a176541cd8ac461add31f9cbe34e022fa15d04e48ef2325656b7::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 8, b"CTO", b"Chief Troll Officer", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1657356586866855936/OSS3KEHI_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTO>(&mut v2, 4200069000100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

