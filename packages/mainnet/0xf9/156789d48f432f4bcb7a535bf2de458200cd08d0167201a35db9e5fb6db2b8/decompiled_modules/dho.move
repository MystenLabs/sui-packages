module 0xf9156789d48f432f4bcb7a535bf2de458200cd08d0167201a35db9e5fb6db2b8::dho {
    struct DHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHO>(arg0, 6, b"DHO", b"Dogho", x"446f67686f2c207468652066756e6e7920646f67207769746820612063696761722c20646976657320696e746f2063727970746f2120466f6c6c6f7720686973206a6f75726e6579206173206865206c61756e636865732061206d656d65636f696e2c206661636573206368616c6c656e6765732c20616e64206275696c647320612066756e20636f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XU_Mdc_F7kv_J_Zjgko_W2i_Bai_YQCMMD_1oy_Ax5_U_Yy2hou_BZ_Ey_d651777836.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

