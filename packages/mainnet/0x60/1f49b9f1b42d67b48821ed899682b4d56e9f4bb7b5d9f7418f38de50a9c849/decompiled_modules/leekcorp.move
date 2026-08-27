module 0x601f49b9f1b42d67b48821ed899682b4d56e9f4bb7b5d9f7418f38de50a9c849::leekcorp {
    struct LEEKCORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEEKCORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEEKCORP>(arg0, 6, b"LEEKCORP", b"CYBERLEEK", b"We Will No Longer Be Requesting $ For The Release Of GTA 6 Full Build. Solve The Puzzle And The Game Is Yours. If You Can https://leekcorp.arwe.io/ Our Donation Wallet Is On There Too , As We Are Not Charging For The Game Leaks No Longer. Donations A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1787859289924.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEEKCORP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEEKCORP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

