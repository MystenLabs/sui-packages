module 0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel {
    struct SWHEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHEEL>(arg0, 9, b"SWHEEL", b"Shell", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWHEEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWHEEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWHEEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWHEEL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

