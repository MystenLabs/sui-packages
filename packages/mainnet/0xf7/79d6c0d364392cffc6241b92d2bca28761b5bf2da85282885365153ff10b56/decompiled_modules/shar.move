module 0xf779d6c0d364392cffc6241b92d2bca28761b5bf2da85282885365153ff10b56::shar {
    struct SHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAR>(arg0, 9, b"SHAR", b"Sharpei", b"First Sharpei on Sui.X: https://x.com/SHARSui_ |Website: https://www.sharpeisui.shop | TG:https://t.me/SHARSui_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.sharpeisui.shop/images/_4_2_1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

