module 0x40a5845047b4a23adb8ea9421e262aef19e4b38e1c0420b26f92368b317cda97::jimpu {
    struct JIMPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIMPU>(arg0, 6, b"JIMPU", b"Jimpu Coin", x"244a696d707520436f696e2069732074686520646563656e7472616c697a656420746f6b656e206279207374726f6e6765737420234a696d7075436f696e2041726d79200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_Gs_Giv_Le_400x400_593f14636a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIMPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

