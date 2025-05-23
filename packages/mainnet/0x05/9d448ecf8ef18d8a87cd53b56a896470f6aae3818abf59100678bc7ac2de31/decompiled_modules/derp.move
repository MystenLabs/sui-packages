module 0x59d448ecf8ef18d8a87cd53b56a896470f6aae3818abf59100678bc7ac2de31::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DERP>, arg1: 0x2::coin::Coin<DERP>) {
        0x2::coin::burn<DERP>(arg0, arg1);
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"DERP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/derp.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERP>>(v1);
        0x2::coin::mint_and_transfer<DERP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DERP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DERP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

