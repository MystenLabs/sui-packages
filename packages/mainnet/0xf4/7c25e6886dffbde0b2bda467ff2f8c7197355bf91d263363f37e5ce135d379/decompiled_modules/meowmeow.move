module 0xf47c25e6886dffbde0b2bda467ff2f8c7197355bf91d263363f37e5ce135d379::meowmeow {
    struct MEOWMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEOW>(arg0, 6, b"MEOWMEOW", b"MEOW", b"MEOW MEOW MEOW MEOW MEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/31d3538aed2bdc583bd18b082760300c_37f61b8b1f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

