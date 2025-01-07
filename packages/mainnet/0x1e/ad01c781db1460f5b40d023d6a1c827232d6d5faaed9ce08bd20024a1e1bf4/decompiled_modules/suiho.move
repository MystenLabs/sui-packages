module 0x1ead01c781db1460f5b40d023d6a1c827232d6d5faaed9ce08bd20024a1e1bf4::suiho {
    struct SUIHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHO>(arg0, 6, b"SuiHo", b"SuiHomeAlabama", x"537765657420686f6d6520416c6162616d61210a576572652074686520736b6965732061726520736f20626c756521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5568_13009edaa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

