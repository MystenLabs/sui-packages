module 0x3b5b2e1d63de8b97ee591e031c9207fcd824194b34fc2e347ace7a9b3198a7eb::hopfish {
    struct HOPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFISH>(arg0, 6, b"HopFish", b"HopFishSui", x"5468657920736179206669736820646f6e2774206a756d702c2049276d20616e20657863657074696f6e20237375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_a3e10c69ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

