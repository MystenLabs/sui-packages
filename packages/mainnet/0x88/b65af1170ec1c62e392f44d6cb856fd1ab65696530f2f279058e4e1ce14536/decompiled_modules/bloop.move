module 0x88b65af1170ec1c62e392f44d6cb856fd1ab65696530f2f279058e4e1ce14536::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop By Matt Furie", x"4f6e65206f66204d617474204675726965277320637574657374206372656174696f6e7320756e646572204865647a2066616d696c792e200a0a526570726573656e747374696e6720746865206a6967676c7920616e64207761726d2073696465206f662074686520537569206d656d65207370616365207769746820686973206f72616e67652c20736f66742c20617070656172616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_15_03_19_ee943fbc32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

