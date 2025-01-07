module 0xe982c0602e19cc16094c41001a29416177d96ddbb8f54a262bd39761a71a05b7::veithly_faucet {
    struct VEITHLY_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VEITHLY_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VEITHLY_FAUCET>>(0x2::coin::mint<VEITHLY_FAUCET>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VEITHLY_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEITHLY_FAUCET>(arg0, 6, b"VLF", b"veithlyFaucet", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEITHLY_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VEITHLY_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

