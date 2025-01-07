module 0xc30472f0bde1dc9b6404c33e5a32cc82840ad37b1101812e7d1cbff72574302f::nineteen {
    struct NINETEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINETEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINETEEN>(arg0, 6, b"NINETEEN", b"19", b"19 af", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_26_40_51e4fe9a02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINETEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINETEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

