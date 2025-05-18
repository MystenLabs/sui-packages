module 0x5b5e915b3e2bdebe25f14551fe7a834e62062da209c079157f0769993e12179::memeix {
    struct MEMEIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEIX>(arg0, 6, b"MEMEIX", b"ROBOT SUIX", b"FUTURE TECH OF SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747555382671.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

