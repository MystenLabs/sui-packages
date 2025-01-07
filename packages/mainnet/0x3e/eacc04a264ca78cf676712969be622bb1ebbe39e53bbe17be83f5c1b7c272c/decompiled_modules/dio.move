module 0x3eeacc04a264ca78cf676712969be622bb1ebbe39e53bbe17be83f5c1b7c272c::dio {
    struct DIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIO>(arg0, 6, b"DIO", b"VDIO", b"Start to manage your collectibles on SUI Network. VDIO's sleek design and user-friendly features make the experience enjoyable and efficient. $DIO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_23_16_48_85cbc922c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

