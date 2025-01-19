module 0x36a2a0d637c11669adccb01ef1abc961d4be32debaadaee14f6abe8c54305ea6::bls {
    struct BLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLS>(arg0, 9, b"BLS", b"Bolson Coin", b"BolsoCOIN Futura moeda substituta do Drex.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1eba539d09dfe5a6a91a2e9a64a886bablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

