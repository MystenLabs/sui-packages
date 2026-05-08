module 0xab79bda06152382642bf8eb1a8d9b95845fddfb3d494fe8a267b65ab20472fab::sltest {
    struct SLTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhTJQSu_qm6C2fF0M88Tq-_LKEsNybDfeuzg&s";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<SLTEST>(arg0, 6, b"SLTEST", b"SUILab Test Token", b"A test token for SUILab bonding curve integration", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLTEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLTEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

