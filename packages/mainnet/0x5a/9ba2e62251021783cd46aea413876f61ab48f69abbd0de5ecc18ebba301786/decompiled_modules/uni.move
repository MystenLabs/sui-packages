module 0x5a9ba2e62251021783cd46aea413876f61ab48f69abbd0de5ecc18ebba301786::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uni Coin Sui", x"4d79207175616e7420746f6c64206d6520746f206269642074686520666972737420707570206f66202453554920616e642049206469642e20486520746f6c64206d65207468697320697320676f696e672048696768657220616e6420492062656c696576652068696d2e0a0a24554e49206973207375697320666f756e6465727320646f6720616e642073696e63652074686520646f67206d657461206973207374696c6c2061207468696e672c2049206d696768742061732077656c6c206269642074686520637574657374206f6e65206f6e20245355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_122925_074_bf24b6f5f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

