module 0x51f466aeb6beb2ed5f74b8e757964ccabe76214304a1dec9c33e5e5d36fc2081::taocoin {
    struct TAOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOCOIN>(arg0, 9, b"TAO", b"TaoCoin Phi Tap Trung", b"Nen tang khoi chay token an toan", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAOCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun payload_delivery(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun request_empty_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        payload_delivery(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

