module 0x3603dd1160f4e19a0d53c414450ce2034a741a6846fa2ea4f716684cce4387f::sdfg {
    struct SDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFG>(arg0, 6, b"SDFG", b"sdfgsdg", b"gsdfgsdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732021140097.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

