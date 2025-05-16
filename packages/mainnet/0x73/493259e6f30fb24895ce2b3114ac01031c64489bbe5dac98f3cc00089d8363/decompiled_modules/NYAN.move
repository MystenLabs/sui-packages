module 0x73493259e6f30fb24895ce2b3114ac01031c64489bbe5dac98f3cc00089d8363::NYAN {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"NYAN", b"Nyan cat", b"Nyan nyan nyan nyan nyan nyan nyan nyan nyan nyan nyan nyan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSA7Kk7fKt93kb5TS1YS7c8qmxkrc7DruphszuXnQJCuh")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

