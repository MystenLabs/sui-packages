module 0x40ff982af2cf618bc8aea07931530e66150584cf370dd974fc128c61d97e52bf::dildos {
    struct DILDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDOS>(arg0, 6, b"DILDOS", b"Green Dildo", b"Send your friends some Green dildos aka green candlesticks to pump the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_23_234221_69073a5652.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

