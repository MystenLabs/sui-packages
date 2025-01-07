module 0x59158f383c5704eaa9f19bd6f0e98b597860e25c7052f0f0cbdf3912cd43fd9e::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 9, b"ASUI", b"Asuimarill", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pokemondb.net/artwork/avif/azumarill.avif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

