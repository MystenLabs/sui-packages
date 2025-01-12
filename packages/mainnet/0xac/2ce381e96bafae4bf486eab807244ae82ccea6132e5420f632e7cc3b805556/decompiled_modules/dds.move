module 0xac2ce381e96bafae4bf486eab807244ae82ccea6132e5420f632e7cc3b805556::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 6, b"DDS", b"distorteddreams", x"57656c636f6d6520746f20646973746f72746564647265616d732c20776865726520647265616d732067657420646973746f7274656420616e6420537569206e6574776f726b20636f696e206d656d65732077696c6c206d616b6520796f75206c61756768206f7574206c6f7564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_68ef1b0667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

