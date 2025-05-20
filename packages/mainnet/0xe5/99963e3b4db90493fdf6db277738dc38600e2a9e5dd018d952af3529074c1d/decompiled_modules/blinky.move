module 0xe599963e3b4db90493fdf6db277738dc38600e2a9e5dd018d952af3529074c1d::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"Sui Blinky", b"BLINKY, first SUI fish full of splashes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigggzad5ecrjkmeego3frdiaecrwddwoa5oyezvbrjpnx6kp672s4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLINKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

