module 0xe34d46b2358d67915f052ea8f95d22a7f65bf08c55dd1c433609db3ce5d4d3e::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 9, b"PAWS", b"PawsUpFam", x"457665727920436c69636b20696e2054656c656772616d206d61747465727321205475726e20796f7520666f6f747072696e747320696e746f20726577617264732077697468205041575321f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/982e6e9e-0018-40ad-84f7-5d01ded1d1a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

