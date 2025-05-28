module 0xf528a78c38427c8af5b7659032109571096b490146164268c71bac5b6ce28a25::pnia {
    struct PNIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNIA>(arg0, 6, b"PNIA", b"POKENIA", x"506f6bc3a96d6f6e2d7468656d656420636f6d6d756e69747920746f6b656e206f6e20537569204e6574776f726b2e204a6f696e20746865205765623320616476656e7475726520776974682024504f4b454e4941", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiajak5gmvsqxluo4azppis5apcadax7cynjh2kpori47ijlf3zlee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PNIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

