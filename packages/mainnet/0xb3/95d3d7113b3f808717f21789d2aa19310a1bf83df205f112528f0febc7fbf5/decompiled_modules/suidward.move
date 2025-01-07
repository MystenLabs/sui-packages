module 0xb395d3d7113b3f808717f21789d2aa19310a1bf83df205f112528f0febc7fbf5::suidward {
    struct SUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDWARD>(arg0, 6, b"SUIDWARD", b"Suidward Tentacles", x"6d6f73746c7920756e706c656173616e742061727469737420616e64206d7573696369616e2e200a7369676d6120616e6420676967612053554944574152440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_14_01_02_6c24ed6353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

