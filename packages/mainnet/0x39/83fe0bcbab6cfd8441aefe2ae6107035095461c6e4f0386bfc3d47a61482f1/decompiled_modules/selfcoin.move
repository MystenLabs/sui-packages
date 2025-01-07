module 0x3983fe0bcbab6cfd8441aefe2ae6107035095461c6e4f0386bfc3d47a61482f1::selfcoin {
    struct SELFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFCOIN>(arg0, 6, b"SELFCOIN", b"SC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SELFCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SELFCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SELFCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

