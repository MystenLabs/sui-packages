module 0xfb0b0056412aaf69faf544fd5b8d3d05e8df3704bdb4a330ffdd540fa1f256c0::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPIN>(arg0, 6, b"PIPPIN", b"Pippin", x"576974682061207477697374206f6620686973207374697272657220616e64206120646173680a6f662064656c696768742c2050697070696e73207061696e74696e6720616476656e74757265730a617265207368696e696e672062726967687421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_from_2024_12_24_01_58_12_92710b25ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

