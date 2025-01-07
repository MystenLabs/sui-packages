module 0x2dab219d2cb7d89ece6531585fb345a53b60b4405e3474daed79e4b7b3bee78e::koisui {
    struct KOISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOISUI>(arg0, 6, b"KoiSui", b"Koi Sui", x"4120426f6c642046697368204d616b696e67205761766573206f66205765616c746820696e2074686520537569204f6365616e200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_soi_bd7827d7ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

