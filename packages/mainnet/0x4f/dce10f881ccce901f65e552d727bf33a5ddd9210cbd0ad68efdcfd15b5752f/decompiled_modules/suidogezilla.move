module 0x4fdce10f881ccce901f65e552d727bf33a5ddd9210cbd0ad68efdcfd15b5752f::suidogezilla {
    struct SUIDOGEZILLA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDOGEZILLA>, arg1: 0x2::coin::Coin<SUIDOGEZILLA>) {
        0x2::coin::burn<SUIDOGEZILLA>(arg0, arg1);
    }

    fun init(arg0: SUIDOGEZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGEZILLA>(arg0, 2, b"SUIDOGEZILLA", b"SUIDOGEZILLA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogezillacoin.com/wp-content/uploads/2021/12/DogeZilla_MERCH-640x503.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGEZILLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGEZILLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOGEZILLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDOGEZILLA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

