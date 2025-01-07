module 0x2544432b3f33ca14b7c4d9b1e96e5c3c715ea300a4dbc1efcf2ae280bdc98556::trollface {
    struct TROLLFACE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TROLLFACE>, arg1: 0x2::coin::Coin<TROLLFACE>) {
        0x2::coin::burn<TROLLFACE>(arg0, arg1);
    }

    fun init(arg0: TROLLFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLFACE>(arg0, 2, b"FACE", b"FACE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.im.ge/2023/05/08/ueffQD.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLFACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLFACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TROLLFACE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TROLLFACE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

