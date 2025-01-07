module 0x6874ef6e36316d3fc2f075648c57b269d2b48df5da15d2e74676715d6e74fb8a::hnk {
    struct HNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNK>(arg0, 6, b"Hnk", b"Honk", b"The Meme Coin That's About to Get REALLY Loud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000824196_9d5ea78a86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

