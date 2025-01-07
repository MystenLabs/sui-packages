module 0xd63012144ace621f0c4defd16f7679418967255a396e9563b62bd4316589f6d6::clam {
    struct CLAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAM>(arg0, 6, b"CLAM", b"Clam On Sui", x"0a4e6f7468696e6720746f2073656520686572652e204a7573742061206375746520636c616d2066726f6d205375692e0a0a4120636c616d20746861742077696c6c206c6f6f6b20666f7220796f75207768656e20796f7527726520646976696e6720696e207468652064656570207365612e200a0a4a75737420646f6e277420746f7563682068696d2e204865277320696e6372656469626c79207368792e205577752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_20_33_59_0d6f5b997e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

