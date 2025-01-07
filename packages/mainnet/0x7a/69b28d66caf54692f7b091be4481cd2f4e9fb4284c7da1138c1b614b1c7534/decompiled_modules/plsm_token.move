module 0x7a69b28d66caf54692f7b091be4481cd2f4e9fb4284c7da1138c1b614b1c7534::plsm_token {
    struct PLSM_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PLSM_TOKEN>, arg1: 0x2::coin::Coin<PLSM_TOKEN>) {
        0x2::coin::burn<PLSM_TOKEN>(arg0, arg1);
    }

    fun init(arg0: PLSM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLSM_TOKEN>(arg0, 9, b"PLSM", b"PLSM", b"PLSM is the native token of Plasmaverse: Multi-Phase ARPG Game on Metaverse  in Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.thirdwebcdn.com/ipfs/Qmbf9KikVv1ApYhWyhTXo64CuDVF15XepM5qDxBNcwBcVU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLSM_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLSM_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLSM_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PLSM_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

