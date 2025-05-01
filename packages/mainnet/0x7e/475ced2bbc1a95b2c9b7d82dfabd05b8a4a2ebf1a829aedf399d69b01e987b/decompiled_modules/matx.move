module 0x7e475ced2bbc1a95b2c9b7d82dfabd05b8a4a2ebf1a829aedf399d69b01e987b::matx {
    struct MATX has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MATX>, arg1: 0x2::coin::Coin<MATX>) {
        assert!(true == false, 100);
        0x2::coin::burn<MATX>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MATX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<MATX>(0x2::coin::supply<MATX>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MATX>>(0x2::coin::mint<MATX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MATX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATX>(arg0, 5, b"MATX", b"MATX", b"MATX token created via SUI Surfer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/rZMsWqEJbbLI-APSWMtI6leuns4zY--EOqDFvxGK5Zg?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

