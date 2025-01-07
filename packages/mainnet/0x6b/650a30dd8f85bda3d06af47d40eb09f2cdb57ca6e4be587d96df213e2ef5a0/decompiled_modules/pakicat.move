module 0x6b650a30dd8f85bda3d06af47d40eb09f2cdb57ca6e4be587d96df213e2ef5a0::pakicat {
    struct PAKICAT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAKICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAKICAT>>(0x2::coin::mint<PAKICAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAKICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKICAT>(arg0, 6, b"Sui Paki Cat", b"PakiCat", b"Sui Paki Cat Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAKICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

