module 0xe0fa83fdc88c30ca88998a95d4c0c90f63edb764a0cd2c7d3bc48c66e56703c9::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"Sharke", x"2047657420726561647920746f206469766520696e746f20746865206465657020616e6420726964652074686520776176657320776974682075732e0a4e6861636b204e6861636b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sherk_087320b0a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

