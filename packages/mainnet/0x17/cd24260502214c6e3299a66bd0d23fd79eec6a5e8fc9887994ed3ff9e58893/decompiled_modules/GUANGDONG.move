module 0x17cd24260502214c6e3299a66bd0d23fd79eec6a5e8fc9887994ed3ff9e58893::GUANGDONG {
    struct GUANGDONG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUANGDONG>, arg1: 0x2::coin::Coin<GUANGDONG>) {
        0x2::coin::burn<GUANGDONG>(arg0, arg1);
    }

    fun init(arg0: GUANGDONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGDONG>(arg0, 9, b"GUANGDONG", b"GUANGDONG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/C1rLptZ/guangdong.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUANGDONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANGDONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUANGDONG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUANGDONG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

