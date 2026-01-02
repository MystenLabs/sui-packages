module 0xa95095dddcb3b8b1a7b7c3f2ad545a9a961035d9f4d203b0752212366079bd16::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: 0x2::coin::Coin<DINO>) {
        0x2::coin::burn<DINO>(arg0, arg1);
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 9, b"DINO", b"DINOSUI", b"DINO DINO BUY After The bull Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://suicreate.com/uploads/logo_1767348338714_597ebb87.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DINO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

