module 0x3ee2e696455b3a6fa5662ce223c7ab7e1596a637cc2aee44c5f562d785f49b6a::gokus {
    struct GOKUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKUS>(arg0, 9, b"GOKUS", b"Goku", b"Goku super saiyan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8ca70e6-f2aa-4dbd-b7a4-f0601514ae24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

