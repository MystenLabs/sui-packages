module 0xff1c7c70695d886df5c0c9b547f4bc8bf9dfca2a313db6cc988a631d81d7015e::dujo {
    struct DUJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUJO>(arg0, 6, b"DUJO", b"Duck Joker", x"4475636b204a6f6b657220436f696e2069732061207768696d736963616c20616e6420656e676167696e67206d656d65636f696e200a74686174206d65726765732074686520706c617966756c206e6174757265206f66206475636b732077697468207468652069636f6e69632c200a6d697363686965766f757320636861726163746572206f6620746865204a6f6b65722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dujo_sui_08f1ebd1e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

