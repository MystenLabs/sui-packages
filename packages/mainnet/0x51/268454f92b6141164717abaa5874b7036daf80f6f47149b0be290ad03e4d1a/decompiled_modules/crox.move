module 0x51268454f92b6141164717abaa5874b7036daf80f6f47149b0be290ad03e4d1a::crox {
    struct CROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROX>(arg0, 6, b"CROX", b"Crox the blue dyno", x"496d6167696e65206120776f726c6420776865726520796f75206e6f206c6f6e676572206e65656420746f20776f726b20617420706c61636573206c696b65204d63446f6e616c6473206f72206f7468657220392d746f2d35206a6f6273206a75737420627579696e67202443524f580a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/crox_3_f93ebeadad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

