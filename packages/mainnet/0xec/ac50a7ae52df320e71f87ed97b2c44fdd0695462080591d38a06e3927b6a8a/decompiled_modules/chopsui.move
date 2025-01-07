module 0xecac50a7ae52df320e71f87ed97b2c44fdd0695462080591d38a06e3927b6a8a::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHOPSUI>, arg1: 0x2::coin::Coin<CHOPSUI>) {
        0x2::coin::burn<CHOPSUI>(arg0, arg1);
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 5, b"CHOP", b"CHOPSUI", b"Chopsui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://violet-electoral-camel-741.mypinata.cloud/ipfs/QmUAQdB7kCHakcgFwTP6PcXBLZwrhbdufmMuithVwDBZTh")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHOPSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHOPSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

