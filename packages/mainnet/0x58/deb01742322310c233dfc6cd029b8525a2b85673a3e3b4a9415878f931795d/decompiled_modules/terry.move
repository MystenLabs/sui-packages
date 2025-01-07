module 0x58deb01742322310c233dfc6cd029b8525a2b85673a3e3b4a9415878f931795d::terry {
    struct TERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERRY>(arg0, 6, b"TERRY", b"Terry The Disgruntled Turtle", b"Terry The Disgruntled Turtle On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Avatar_fbeda52cdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

