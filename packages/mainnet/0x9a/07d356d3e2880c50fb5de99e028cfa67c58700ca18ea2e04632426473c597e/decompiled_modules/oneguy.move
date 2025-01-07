module 0x9a07d356d3e2880c50fb5de99e028cfa67c58700ca18ea2e04632426473c597e::oneguy {
    struct ONEGUY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONEGUY>, arg1: 0x2::coin::Coin<ONEGUY>) {
        0x2::coin::burn<ONEGUY>(arg0, arg1);
    }

    fun init(arg0: ONEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEGUY>(arg0, 9, b"1GUY", b"1GUY", b"$1GUY EeOneGuy Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmX3HhLMvczWJ33SrDjnCPonxor912mXTivf3QMbFm2BB8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONEGUY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEGUY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ONEGUY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ONEGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

