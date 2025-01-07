module 0xadc705f7d3c3f575b561d031433e0b8d93c634b57bbdcdbba5d50bd6c9c137f::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 6, b"POO", b"Mr Hankey The Christmas Poo", b"Howdy Ho! Merry Christmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mrhankeyprof_d22bb9100b.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POO>>(v1);
    }

    // decompiled from Move bytecode v6
}

