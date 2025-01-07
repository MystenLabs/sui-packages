module 0x612a758c4e51e491dc23cf87b4b2cf6d0f6eb4de1659a85f3233baa2b2f59a0f::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"BLOB ON SUO", x"24426c6f622c20746865206d656d65636f696e207468617473206865726520746f2074616b652074686520405375694e6574776f726b2062792073746f726d20616e64206c656176652065766572796f6e6520696e2073746974636865732e204e6f7720696d6167696e65207468617420626c6f62207374756d626c696e67206f6e746f2074686520626c6f636b636861696e2c20776967676c696e672069747320776179207468726f756768207468652063727970746f20776f726c642c20616e642063617573696e672061206672656e7a792e2054686174732024426c6f622c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036793_898ec0a4a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

