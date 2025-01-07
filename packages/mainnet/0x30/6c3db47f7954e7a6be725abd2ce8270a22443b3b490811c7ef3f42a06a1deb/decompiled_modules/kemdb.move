module 0x306c3db47f7954e7a6be725abd2ce8270a22443b3b490811c7ef3f42a06a1deb::kemdb {
    struct KEMDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMDB>(arg0, 9, b"KEMDB", b"ksndb", b"snbw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/848b3ffd-944d-43bc-a390-6b35a729c9da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEMDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

