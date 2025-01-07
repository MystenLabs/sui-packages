module 0xbe891a85d9db609375b2376c7b80f09d8be1d8b4676fb7e607a170da596581e::supra {
    struct SUPRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: 0x2::coin::Coin<SUPRA>) {
        0x2::coin::burn<SUPRA>(arg0, arg1);
    }

    fun init(arg0: SUPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPRA>(arg0, 9, b"SUP", b"SUPRA", b"Supra Token On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmP4CX2mcHPoWyLrFNm7SX2m6hUVmevTZejZy1vQ7aLeB9/PEPE-price-bull-300x300.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

