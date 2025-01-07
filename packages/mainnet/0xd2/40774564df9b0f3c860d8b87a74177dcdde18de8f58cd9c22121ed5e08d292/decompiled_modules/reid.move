module 0xd240774564df9b0f3c860d8b87a74177dcdde18de8f58cd9c22121ed5e08d292::reid {
    struct REID has drop {
        dummy_field: bool,
    }

    fun init(arg0: REID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REID>(arg0, 6, b"Reid", b"Riley55555", b"anything can happen, you just have to believe it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010138_5976f80ce1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REID>>(v1);
    }

    // decompiled from Move bytecode v6
}

