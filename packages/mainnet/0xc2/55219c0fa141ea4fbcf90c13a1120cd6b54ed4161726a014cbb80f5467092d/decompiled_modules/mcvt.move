module 0xc255219c0fa141ea4fbcf90c13a1120cd6b54ed4161726a014cbb80f5467092d::mcvt {
    struct MCVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCVT>(arg0, 6, b"MCVT", b"Mill City ", x"4d696c6c20436974792056656e7475726573204949492c204c74642e20416e6e6f756e63657320243435302c3030302c303030205072697661746520506c6163656d656e7420746f20496e6974696174652053756920547265617375727920537472617465677920210a0a245355492077696c6c2073657276652061732074686520436f6d70616e79e2809973207072696d61727920747265617375727920726573657276652061737365742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753708038359.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCVT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCVT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

