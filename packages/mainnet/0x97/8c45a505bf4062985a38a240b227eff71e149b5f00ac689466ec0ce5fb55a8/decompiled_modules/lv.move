module 0x978c45a505bf4062985a38a240b227eff71e149b5f00ac689466ec0ce5fb55a8::lv {
    struct LV has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LV>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LV>(arg0, arg1, @0xe8dfffc3e2663c145f95382383fa768c6a524a59229711f7f0b731c915127fe, arg2);
        0x2::coin::deny_list_v2_add<LV>(arg0, arg1, @0xe3ff471163253a9b1b3bc87ceff23f9c2fcc93ea2c9e24ba6d7cd46ffb8a6b26, arg2);
        0x2::coin::deny_list_v2_add<LV>(arg0, arg1, @0xc947a71d8ee992644427d636b970dc6c5690d9bcff1a36aa799e9cca5574bd58, arg2);
    }

    fun init(arg0: LV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LV>(arg0, 9, b"LV", b"LV", b"luyisvden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-65N5F4cdyg2apksdKdchR5?se=2025-02-11T06%3A50%3A16Z&sp=r&sv=2024-08-04&sr=b&rscc=max-age%3D604800%2C%20immutable%2C%20private&rscd=attachment%3B%20filename%3D0329cbf8-719b-47c1-850e-fe8db6d9bd97.webp&sig=tvdBcMlBk%2BDJ2U5fI9Jzm/gJAgB3vSdUcz0VlmRlGC8%3D")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LV>>(v2);
        0x2::coin::mint_and_transfer<LV>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LV>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

