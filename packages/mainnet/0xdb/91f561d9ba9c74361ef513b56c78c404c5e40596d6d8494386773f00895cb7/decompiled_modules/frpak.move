module 0xdb91f561d9ba9c74361ef513b56c78c404c5e40596d6d8494386773f00895cb7::frpak {
    struct FRPAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRPAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRPAK>(arg0, 6, b"FRPAK", b"FRPAKBOB sui", x"20465250414b424f422069732063616c6c696e672e20596f75722063686f69636520746f2067657420207769746820200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tvn_Ya_XYA_400x400_9cc32aa3ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRPAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRPAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

