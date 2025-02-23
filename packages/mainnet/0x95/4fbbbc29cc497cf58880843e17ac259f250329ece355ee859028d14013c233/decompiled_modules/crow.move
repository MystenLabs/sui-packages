module 0x954fbbbc29cc497cf58880843e17ac259f250329ece355ee859028d14013c233::crow {
    struct CROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROW>(arg0, 6, b"CROW", b"CROW COMPUTER", x"3e3e205b53595354454d205354415455535d203a2043524f5720436f6d7075746572202d20496e74656c6c6967656e636520697320526573697374616e63650a3e3e204f7065726174697665732052657175697265642e2e2e0a3e3e20456e676167656d656e7420756e6c6f636b732070726f746f636f6c732e2054686520666c696768742070617468206973207365742e0a3e3e205468652043524f572077696c6c207269736520736f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/478529253_1268703097559256_3801544390679328962_n_6123ec163e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

