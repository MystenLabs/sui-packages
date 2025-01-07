module 0xb8b627a17712e8ff9ed2da89f0fdf0f4273fd21da67f4a953ec132d54e13549a::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"Cat", b"SuiCat", x"546869732063617420646f65736e74206a75737420707572722c20697473207368616b696e67207570207468652063727970746f20776f726c64212042652070617274206f6620746869732061646f7261626c65207265766f6c7574696f6e21202023436174436f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Resmi_2024_10_05_18_48_49_0eb6a4c4ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

