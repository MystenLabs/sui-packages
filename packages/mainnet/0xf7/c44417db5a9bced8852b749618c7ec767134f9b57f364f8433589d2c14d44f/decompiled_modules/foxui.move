module 0xf7c44417db5a9bced8852b749618c7ec767134f9b57f364f8433589d2c14d44f::foxui {
    struct FOXUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXUI>(arg0, 6, b"FOXUI", b"FOX INU OF SUI", x"464f5820494e55204f4e205355490a0a44455820505245504149440a0a4c45545320424f4e44204954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foxui_logo_new_00680f75b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

