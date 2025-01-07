module 0xee576e4a8f33f61eabeedcbeac867146c60769b498b68ccbaa14ee88a408cf15::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 6, b"LUGA", b"LUGA Whale", b"hallo I'm a beluga whale. aqualuga.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_120821_973ea448f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

