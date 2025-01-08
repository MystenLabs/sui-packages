module 0xde15e84aca8db903281ba10056cc293d75447b6b1139a944889a1af794a84d73::musuic {
    struct MUSUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSUIC>(arg0, 6, b"MUSUIC", b"muSUIc Dream", x"576161616161697421204265666f726520796f75206275792c20706c65617365206c697374656e20746f20746865206d75535549632e20496620796f75206c696b652069742c2062757920736f6d65206f72206c696b6520616e6420666f6c6c6f77206d652e200a49206d616465207468697320746f206d616b65206d792034307468207965617220696e207468697320776f726c64206d6f6d6f7261626c652e20416e6420492077696c6c207374617274206372656174696e672061727473206c696b6520746869732e2054686520706f73736962696c69746965732061726520656e646c6573732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736345913238.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

