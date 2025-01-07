module 0x110b311628ffaf0af27f7858941a8058d898a4a47ae800a838dc21bbca9cf669::puca {
    struct PUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCA>(arg0, 6, b"PUCA", b"PUCA the Purple Cat", b"Hi, my name's PUCA  I'm a cat and I'm purple, purr ^_^", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Adt3_s_Xp_400x400_37fc4d1684.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

