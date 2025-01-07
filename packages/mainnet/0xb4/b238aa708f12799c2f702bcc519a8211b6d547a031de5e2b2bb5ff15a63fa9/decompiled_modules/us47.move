module 0xb4b238aa708f12799c2f702bcc519a8211b6d547a031de5e2b2bb5ff15a63fa9::us47 {
    struct US47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: US47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US47>(arg0, 6, b"US47", b"Trump USA - 47", b"TRUMP - US47 represents TEAM AMERICA - the most famous people who supported Trump in the election. Musk, Rogan, Tate, and many other KOLs choose the true leader of America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_13_40_14_ca6171fef7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<US47>>(v1);
    }

    // decompiled from Move bytecode v6
}

