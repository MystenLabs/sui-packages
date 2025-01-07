module 0x70f663cf914c837fc50b25abc58a89543547eb411223f7fbd17bfc5af9da996::dip {
    struct DIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIP>(arg0, 6, b"DIP", b"Dog In Pool", b"Introducing Dog in Pool - The Coolest Pup on the Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DIP_1545f3de7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

