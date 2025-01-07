module 0x96c111c41c0a0ab09d9853a31d87b9eb593a53c9b8db7fd837bac8b30b34bc8b::wang {
    struct WANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANG>(arg0, 6, b"WANG", b"Wang", b"Wang The Orca, The Dude We All Love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wangggg_2fbcd62ab2.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

