module 0xab192c9b00b394d5a7a44086c1c98845f634280f28011de131004f1526ee709c::flt {
    struct FLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLT>(arg0, 6, b"FLT", b"Fallocuster", b"Fallocuster ($FLT)  The Ultimate Community-Driven Meme Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053379_54422ce3b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

