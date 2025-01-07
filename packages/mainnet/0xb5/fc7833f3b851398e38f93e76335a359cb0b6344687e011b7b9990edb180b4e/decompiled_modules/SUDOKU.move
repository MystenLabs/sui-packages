module 0xb5fc7833f3b851398e38f93e76335a359cb0b6344687e011b7b9990edb180b4e::SUDOKU {
    struct SUDOKU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUDOKU>, arg1: 0x2::coin::Coin<SUDOKU>) {
        0x2::coin::burn<SUDOKU>(arg0, arg1);
    }

    fun init(arg0: SUDOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOKU>(arg0, 9, b"SUDOKU", b"SUDOKU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/sK2X4pd/sudoku.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUDOKU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUDOKU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

