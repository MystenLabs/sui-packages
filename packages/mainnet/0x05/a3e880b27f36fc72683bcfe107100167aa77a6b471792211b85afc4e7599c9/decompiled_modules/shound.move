module 0x5a3e880b27f36fc72683bcfe107100167aa77a6b471792211b85afc4e7599c9::shound {
    struct SHOUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOUND>(arg0, 6, b"SHOUND", b"SUI HOUND", b"\"Run with Speed, Build with Strength -- The Power of SuiHound\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_19_14_40_05_e3d3db3945.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOUND>>(v1);
    }

    // decompiled from Move bytecode v6
}

