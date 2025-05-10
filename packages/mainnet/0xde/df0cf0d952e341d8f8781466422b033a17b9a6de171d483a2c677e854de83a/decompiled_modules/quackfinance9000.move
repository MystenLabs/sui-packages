module 0xdedf0cf0d952e341d8f8781466422b033a17b9a6de171d483a2c677e854de83a::quackfinance9000 {
    struct WQUACK has drop {
        is_special: bool,
    }

    fun internal_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WQUACK{is_special: true};
        let (v1, v2) = 0x2::coin::create_currency<WQUACK>(v0, 9, b"WQUACK", b"weird quack", b"weirdest duck token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/chX1zR5j/images-q-tbn-ANd9-Gc-Rm-Dwyc-Vz-Cs-Wa-Zx5-Aa-CTeqz6e8q-Lbt8-Ua-Qz7g-s.jpg")), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WQUACK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WQUACK>>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WQUACK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WQUACK>(arg0, arg1, arg2, arg3);
    }

    public entry fun start(arg0: &mut 0x2::tx_context::TxContext) {
        internal_init(arg0);
    }

    // decompiled from Move bytecode v6
}

