module 0x369377760f7670257e15ce905612d3fe5a42a98f95191b1a255e588013d608c::miao {
    struct MIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAO>(arg0, 6, b"MIAO", b"Miao On Sui", b"MIAO Coin is a cute and adorable Real Emotionless Cat Meow Meow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250429_230834_426_a781b07434.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

