module 0xb72e963062e3497f7bb69976f033f37ccbbc03210ae534e0355a870c0adf3669::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 2, b"MEW", b"mew", b"mew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/lYWq1uJ.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

