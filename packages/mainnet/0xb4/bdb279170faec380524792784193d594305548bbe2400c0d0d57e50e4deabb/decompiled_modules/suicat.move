module 0xb4bdb279170faec380524792784193d594305548bbe2400c0d0d57e50e4deabb::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nSUICAT";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dSUICAT is the meme cat of SUI Chain";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/heuSD_bjTaQtwdEc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

