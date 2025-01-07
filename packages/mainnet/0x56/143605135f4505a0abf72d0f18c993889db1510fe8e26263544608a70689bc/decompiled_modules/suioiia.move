module 0x56143605135f4505a0abf72d0f18c993889db1510fe8e26263544608a70689bc::suioiia {
    struct SUIOIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOIIA>(arg0, 6, b"SUIOiia", b"Sui Spinning Cat", b"OiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiiaOiia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_cat_d0b8cc42c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOIIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOIIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

