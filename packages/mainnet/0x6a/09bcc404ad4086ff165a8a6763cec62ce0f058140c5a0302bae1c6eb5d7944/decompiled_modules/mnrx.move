module 0x6a09bcc404ad4086ff165a8a6763cec62ce0f058140c5a0302bae1c6eb5d7944::mnrx {
    struct MNRX has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MNRX>, arg1: 0x2::coin::Coin<MNRX>) {
        assert!(false == false, 100);
        0x2::coin::burn<MNRX>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MNRX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<MNRX>(0x2::coin::supply<MNRX>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MNRX>>(0x2::coin::mint<MNRX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MNRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNRX>(arg0, 9, b"MNRX", b"Minerx", b"A meme with have fun make money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/BzcGWQv2tovbhxiKkEGCENHw_Hi_C5FgSdo3IWld6Bo?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNRX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNRX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

