module 0x2152eb58395b4d7d5eba797f47942c4bfad2868cb3d45bc9219415ec6f5b1cfc::twiaglefaucet {
    struct TWIAGLEFAUCET has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TWIAGLEFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TWIAGLEFAUCET>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TWIAGLEFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIAGLEFAUCET>(arg0, 6, b"twiagleFaucet", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIAGLEFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TWIAGLEFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

