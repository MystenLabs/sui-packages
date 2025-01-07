module 0xbc5f4d94154606be9e5fbbb0e703114d4b452ce15ad54ecee798a437a545fa8::nekon {
    struct NEKON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKON>(arg0, 6, b"NEKON", b"Nekon cat", x"4e454b4f4e3a4e454b4f4e206973206120646563656e7472616c697365642063727970746f63757272656e6379206261736564206f6e2074686520457468657265756d20626c6f636b636861696e2c2077686963682061696d7320746f2065766f6b65206e6f7374616c67696120616e64206361707475726520746865206f726967696e616c206d656d65207370697269742e20416c74686f756768204d616e656b69206973207665727920706f70756c61722c2070656f706c65207365656d20746f20626520736c6f776c7920666f7267657474696e672074686174204e454b4f4e20697320612043617420696e2061206b696d6f6e6f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nekon_cat_615ebe1422.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKON>>(v1);
    }

    // decompiled from Move bytecode v6
}

