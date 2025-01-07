module 0x6e63c05971fcef5b5135337f9ad9b9a627d8728cccb9f6c4ca42eef74920ae5d::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Sui Wukong", b"A shining star is rising on SUI , which perfectly combines ancient wisdom with modern technology. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MONKEY_517ce8ad7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

