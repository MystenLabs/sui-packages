module 0x56ec2b9ee36e35bfd40279f82d67954c22493645744b76bfe720e3d3d963d914::smozartai {
    struct SMOZARTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOZARTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOZARTAI>(arg0, 6, b"SMOZARTAI", b"MOZART AI", b"FIRST UTILITY TOKEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3559_b23ad491fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOZARTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOZARTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

