module 0x1a67a401700344acc6a1d076bb60fbad5803a47cf6ab7e2dd5de5dc7c6ee1eda::diamondsui {
    struct DIAMONDSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DIAMONDSUI>, arg1: 0x2::coin::Coin<DIAMONDSUI>) {
        0x2::coin::burn<DIAMONDSUI>(arg0, arg1);
    }

    fun init(arg0: DIAMONDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMONDSUI>(arg0, 9, b"diamond sui", b"dsui", b"diamond hands diamond sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMONDSUI>>(v1);
        0x2::coin::mint_and_transfer<DIAMONDSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMONDSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIAMONDSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DIAMONDSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

