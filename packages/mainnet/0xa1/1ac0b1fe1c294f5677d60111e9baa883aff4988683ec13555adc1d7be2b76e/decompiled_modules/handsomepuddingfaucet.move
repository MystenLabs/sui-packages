module 0xa11ac0b1fe1c294f5677d60111e9baa883aff4988683ec13555adc1d7be2b76e::handsomepuddingfaucet {
    struct HANDSOMEPUDDINGFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANDSOMEPUDDINGFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDSOMEPUDDINGFAUCET>(arg0, 4, b"HandsomePuddingFaucet", b"HandsomePuddingFaucet", b"this is HandsomePuddingFaucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDSOMEPUDDINGFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDSOMEPUDDINGFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

