module 0xd5e83000aa7a3502c3e7b12c539cb5b191b100c50cd1e34c3417be3b6222d394::tyke {
    struct TYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYKE>(arg0, 6, b"TYKE", b"Type on Sui", b"This fuzzling flurry of delight  thats Tyke!An eager bob that anticipates more shenanigans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_768x768_325c67981e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

