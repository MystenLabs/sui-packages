module 0x650ff6792bcaab5a2944e21b772a120c351afff19e681bc4c086863089bdad45::jasonsui {
    struct JASONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASONSUI>(arg0, 6, b"JASONSUI", b"JASON", b"JASONSUI IS JASON ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_2982115495_87a9727ed6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JASONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

