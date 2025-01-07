module 0x94d638f54c9a369df16271a3f71e3cccbf18b0ecf9a32cbdad3de2883571cbda::suq {
    struct SUQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUQ>(arg0, 6, b"SUQ", b"Suq Inu", x"245355512069732074686520636f6d6d756e69747920636f696e206f662053756920636861696e2e204c65742773206d616b65207468652053756920636861696e20677265617420746f67657468657220616e64207269646520746865206e6578742077617665206f66206d656d65206d616e69612e0a0a24535551206974206672656e7321210a0a4a6f696e2074686520636f6d6d756e6974793a2068747470733a2f2f742e6d652f53757143686174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/warren_smith_06df3fca9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

