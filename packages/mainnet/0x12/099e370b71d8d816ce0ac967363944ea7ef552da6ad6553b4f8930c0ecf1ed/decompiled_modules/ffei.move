module 0x12099e370b71d8d816ce0ac967363944ea7ef552da6ad6553b4f8930c0ecf1ed::ffei {
    struct FFEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFEI>(arg0, 9, b"FFEI", b"FoxFiesta", b"FoxFiesta is an innovative and playful cryptocurrency inspired by the clever and resourceful nature of foxes. Designed to bring a touch of whimsy to the world of digital finance, FoxFiesta combines the appeal of meme culture with the robust technology of blockchain, offering a unique investment opportunity for both crypto enthusiasts and casual investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FFEI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFEI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

