module 0xd4e59108332d579cbfe6d7b9a20865596e407e1056d3ceec5792587954a45ec5::polar {
    struct POLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAR>(arg0, 6, b"POLAR", b"Polar Sui", x"457870657269656e63652074686520667574757265206f662063727970746f20776974682024504f4c415220537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731770888807.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

