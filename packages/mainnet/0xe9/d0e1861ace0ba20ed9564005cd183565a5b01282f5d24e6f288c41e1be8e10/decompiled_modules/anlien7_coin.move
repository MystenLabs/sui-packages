module 0xe9d0e1861ace0ba20ed9564005cd183565a5b01282f5d24e6f288c41e1be8e10::anlien7_coin {
    struct ANLIEN7_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANLIEN7_COIN>, arg1: 0x2::coin::Coin<ANLIEN7_COIN>) {
        0x2::coin::burn<ANLIEN7_COIN>(arg0, arg1);
    }

    fun init(arg0: ANLIEN7_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANLIEN7_COIN>(arg0, 9, b"ANLIEN7", b"ANLIEN7_COIN", b"ANLIEN7 Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANLIEN7_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANLIEN7_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANLIEN7_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANLIEN7_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

