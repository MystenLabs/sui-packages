module 0x8b2df07fa866f92aa37b947abdfd513269495fedf7ed7422fb5a7c2b1f3a3ab7::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEE SUI", x"576520617265202442454520666f72207468652070656f706c652e2020200a0a5468652062656520686173206465636964656420746f20636f6d62696e652069747320686f6e6579207769746820776174657220616e64206f6666657220657863656c6c656e742062656e65666974732e0a0a54686520737765657465737420746f6b656e206f6e205375692e204f757220636f6d6d756e69747920697320626f6e6420746f676574686572207769746820686f6e65792e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bee_6c2c195e48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

