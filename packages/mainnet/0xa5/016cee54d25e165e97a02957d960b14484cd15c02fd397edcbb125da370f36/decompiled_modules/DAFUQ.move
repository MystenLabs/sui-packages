module 0xa5016cee54d25e165e97a02957d960b14484cd15c02fd397edcbb125da370f36::DAFUQ {
    struct DAFUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAFUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAFUQ>(arg0, 6, b"DAFUQ", b"Dafuq", b"????????", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmaMv4UJC8KQM4i55djyjz9JpKn2UUpPgoxAaLtQufBNMZ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAFUQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAFUQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

