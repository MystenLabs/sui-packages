module 0x7a96dbd89286e943d61f6b37c6ca84e4a8bf8c1a1eeb6ab1f4eda347b5682b2f::tuxpenguin {
    struct TUXPENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUXPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUXPENGUIN>(arg0, 6, b"TuxPenguin", b"Tux Penguin Sui", b"Meet Tux, the charming penguin from the Arctic, waddling his way to the SUI Blockchain! Join us as Tux brings a wave of cheer and excitement, making SUI the talk of the town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_223831_512_21c08d8c09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUXPENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUXPENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

