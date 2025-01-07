module 0xf66810faa31372f6ec367ba475e74083e1ea6a3c1c560973eb626ae0a93a4847::suiodon {
    struct SUIODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIODON>(arg0, 6, b"SUIODON", b"Suiodon", x"4f646f6e3a2041206d617363756c696e65206e616d65206f66204f6c6420456e676c69736820616e642048756e67617269616e206f726967696e2c0a6d65616e696e67207765616c7468792070726f746563746f72206f72207765616c74687920646566656e6465722e20546869730a70726573746967696f7573206e616d6520656d626f6469657320737472656e67746820616e642070726f737065726974792c206f66666572696e670a6120666f756e646174696f6e206f66207375636365737320616e6420736563757269747920666f722074686f73652077686f20626561722069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_SYR_be_K_400x400_fcb7314515.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

