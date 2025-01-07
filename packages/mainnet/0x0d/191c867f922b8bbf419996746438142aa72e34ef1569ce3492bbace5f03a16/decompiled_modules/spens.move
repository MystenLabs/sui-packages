module 0xd191c867f922b8bbf419996746438142aa72e34ef1569ce3492bbace5f03a16::spens {
    struct SPENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENS>(arg0, 6, b"Spens", b"Space penguin sui", b"Space penguin to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1530_46b1597503.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

