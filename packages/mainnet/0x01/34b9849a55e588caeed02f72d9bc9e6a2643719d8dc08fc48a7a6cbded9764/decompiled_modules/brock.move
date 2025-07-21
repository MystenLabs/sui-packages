module 0x134b9849a55e588caeed02f72d9bc9e6a2643719d8dc08fc48a7a6cbded9764::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BROCK>(arg0, 6, b"BROCK", b"Brock Suilaunch", b"Launch a project on @suilaunchcoin by tagging @BrockOnSUIand including the project name and logo. $Brock + Brock Suilaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_07_21_01_59_29_b401d352fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

