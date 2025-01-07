module 0xc75b90ba952947954ceed595185651ba388404c6253be3779d8df2d74972fd66::fal {
    struct FAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAL>(arg0, 9, b"FAL", b"Falcon Inu", x"46616c636f6e20496e75202846414c292069732061206d656d6520746f6b656e206275696c74206f6e2074686520537569204e6574776f726b2c20626c656e64696e672074686520706c617966756c20737069726974206f66206d656d6520636f696e732077697468205375692773206661737420616e6420656666696369656e7420626c6f636b636861696e20746563686e6f6c6f67792e0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c947a833-1483-4ec0-bc9f-9f2fbd68ecd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

