module 0xb29bde772c753fff7c910fa51fbdfd298e1338e51c21ce27df0dfabbcc7328b9::capys {
    struct CAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYS>(arg0, 6, b"CAPYS", b"SUI CAPYS", x"5355494341505953206275696c64732e20506561636520616e642070726f737065726974792120666f6c6c6f772077686572657665722024434150595320676f65732ef09f958aefb88ff09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957307786.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

