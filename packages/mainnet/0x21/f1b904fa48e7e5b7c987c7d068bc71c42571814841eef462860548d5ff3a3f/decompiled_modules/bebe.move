module 0x21f1b904fa48e7e5b7c987c7d068bc71c42571814841eef462860548d5ff3a3f::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 6, b"BEBE", b"SUIBEBE", x"4920616d2061206d656d652061727469737420796f752063616e277420666f726765742c20757365206d656d657320746f20656e7465727461696e206d7973656c662e202063726561746f722e204e4f2046494e414e4349414c204144564943452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_RG_8_Kl7_400x400_f8fd3a4fcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

