module 0xa5caaa1fcf3fb5ea6be7f25c8b73cbb0f51445ea9db1f1eb3fb0ed805c22fd27::toli {
    struct TOLI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOLI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x2b582f4d2d34d1f0ab5156620d03d7c22db6ad6845ed371d3cde87e88ac362d2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOLI>>(0x2::coin::mint<TOLI>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLI>(arg0, 9, b"TOLI", b"Toli The Trencher", b"Toli The Trencher on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/5tVCSnNp/Qm-WD4-R2-Lk-Bdm-YNz9-A4o-P2e-Mc-PDnoffe13va-Ur-YW2-Vt-Jqh-D.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

