module 0x4763df42a308bbb3c41708ea4fef65337f2457dc6f3a390b89302b672378fb53::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLE>(arg0, 6, b"PICKLE", b"SuiPickle", x"4c69666520756e6465722064612053756920697320626574746572207769746820537569205069636b6c657321200a496e74726f647563696e6720796f7572206661766f72697465206f6365616e20666172696e672074756e69636174652c2074686520537569205069636b6c652e20546869732073616c74792c20737175697368792c2063757465206d656d6520746f6b656e206973206865726520746f20656e6a6f7920746865207761766573206f66207468652053756920626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_pickle_transparent_9318225891.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

