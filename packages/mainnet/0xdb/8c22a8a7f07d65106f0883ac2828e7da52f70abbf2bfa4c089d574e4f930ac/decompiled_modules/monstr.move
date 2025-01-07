module 0xdb8c22a8a7f07d65106f0883ac2828e7da52f70abbf2bfa4c089d574e4f930ac::monstr {
    struct MONSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTR>(arg0, 6, b"MONSTR", b"MONSTERSUI", b"The MONSTER on SUI, bringing bear to the world of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197643_4310682ecd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

