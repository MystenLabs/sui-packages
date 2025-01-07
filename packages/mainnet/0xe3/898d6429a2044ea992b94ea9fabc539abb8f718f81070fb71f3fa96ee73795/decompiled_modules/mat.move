module 0xe3898d6429a2044ea992b94ea9fabc539abb8f718f81070fb71f3fa96ee73795::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 6, b"MAT", b"Move Cat", b"Cat from Movepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Projekt_bez_nazwy_2024_09_27_T155827_091_4b36225b21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

