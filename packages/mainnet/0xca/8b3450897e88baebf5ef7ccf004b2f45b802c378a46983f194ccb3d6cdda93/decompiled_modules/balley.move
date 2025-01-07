module 0xca8b3450897e88baebf5ef7ccf004b2f45b802c378a46983f194ccb3d6cdda93::balley {
    struct BALLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLEY>(arg0, 6, b"BALLEY", b"Bailey Sui", x"4261696c657973206265656e206d616b696e67207175696574206d6f7665732c20616e642074686520696d706163742069732061626f757420746f20626520687567652e205768656e20736f6d656f6e65206c696b65207468617420737465707320696e2c20796f75206b6e6f7720736f6d657468696e67206269672069732061626f757420746f20756e666f6c642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bailey_Sui_3708471be0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

