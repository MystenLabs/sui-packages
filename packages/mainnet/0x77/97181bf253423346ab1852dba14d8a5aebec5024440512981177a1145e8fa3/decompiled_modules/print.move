module 0x7797181bf253423346ab1852dba14d8a5aebec5024440512981177a1145e8fa3::print {
    struct PRINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nBluePrint";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dAn over-engineered schematic for a machine that absolutely does nothing. Built by hyper-technical degens who forgot what the project was actually supposed to build, it now loops liquidity through a maze of pipes forever.";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<PRINT>(arg0, 6, b"PRINT", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/_YHL4NHQ2X-1qsGy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRINT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

