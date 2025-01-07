module 0x17c8740dbcccd80eaebb755c5a1f99c2a79cebb5624a6deb244be6e074b2ecd5::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"POPO ON SUI", b"DUE TO THE MANY SNIPER YESTERDAY. WE HAVE DECIDED TO RELAUNCH POPOSUI. ALL POPOSUI PURCHASED BY DEV WILL BE 100% BURNED.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004286_b3b60c98e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

