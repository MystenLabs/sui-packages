module 0x989d011583715fe10dd1078700bedfdd89dd6132a08298023285fde34c98b5dd::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"Suibaby", x"5472756d70e28099732053756962616279", x"5472756d70e280997320537569626162792e20546865206d6f73742061646f7261626c652062616279206f6e2053756920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739129557354.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBABY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

