module 0xbc8def0777f570d6129a7f8eb022ec6e80d8517ee3549f213f8cba18e29ebeb8::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIMUS>(arg0, 6, b"OPTIMUS", b"OPTIMUSAI", x"496e73706972656420627920456c6f6e277320526f626f742c207765206172652061206d656d652f7061726f647920636f6d6d756e697479206275696c742061726f756e6420616c6c207468696e677320234f5054494d555320204e6f7420616666696c6961746564207769746820582c20456c6f6e206f72205465736c6120496e632e204e6f742066696e616e6369616c206164766963652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y4_F_Od6_XJ_400x400_3936219669.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

