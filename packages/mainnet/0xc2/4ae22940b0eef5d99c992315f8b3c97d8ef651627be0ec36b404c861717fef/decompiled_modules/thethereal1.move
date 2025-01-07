module 0xc24ae22940b0eef5d99c992315f8b3c97d8ef651627be0ec36b404c861717fef::thethereal1 {
    struct THETHEREAL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THETHEREAL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THETHEREAL1>(arg0, 6, b"Thethereal1", b"ethereal works", b"back2work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hangedman_e92c817dcb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THETHEREAL1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THETHEREAL1>>(v1);
    }

    // decompiled from Move bytecode v6
}

