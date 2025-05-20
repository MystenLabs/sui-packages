module 0x31e0d7bc4ffeba4787ea45f5fb26df4a676796e15c0941d94306b9f473d4c625::ANT {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 6, b"ANT", b"An ant", b"ant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmbam2H7HCg5skT9TSUEJeEMxDqQHsKrGkMmTmckFML6W4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

