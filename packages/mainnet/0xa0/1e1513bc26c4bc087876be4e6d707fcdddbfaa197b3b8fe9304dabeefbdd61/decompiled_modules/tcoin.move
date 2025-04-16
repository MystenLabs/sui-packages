module 0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin {
    struct TCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCOIN>(arg0, 8, b"TCOIN", b"TCOIN", b"this is tcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miro.medium.com/v2/resize:fit:720/format:webp/1*PvCkfUq-s61EUoC1trFGnQ.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

