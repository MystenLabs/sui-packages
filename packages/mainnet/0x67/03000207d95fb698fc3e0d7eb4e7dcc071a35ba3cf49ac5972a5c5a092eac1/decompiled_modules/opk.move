module 0x6703000207d95fb698fc3e0d7eb4e7dcc071a35ba3cf49ac5972a5c5a092eac1::opk {
    struct OPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPK>(arg0, 6, b"OPK", b"Orca pengu killer", x"4a6f696e20557320546f6461793a20200a54656c656772616d3a2068747470733a2f2f742e6d652f4f52434150454e47554b494c4c45520a0a547769747465723a2068747470733a2f2f782e636f6d2f4f5243414f4e5355490a0a47657420696e204561726c79210a446f6e74206d69737320796f7572207469636b657420746f20746865206d6f6f6e2120244f504b206973206a7573742067657474696e6720737461727465642c20616e64207468697320697320796f7572206368616e636520746f2062652070617274206f6620746865206e65787420626967206d656d6520636f696e2073656e736174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241219_173747_279_f94315342c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

