module 0x59b51ba6ba9dfd3029bd8f1c886924c14fc65bc7d9c21deae84bb26acc1e793b::openssh {
    struct OPENSSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPENSSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENSSH>(arg0, 6, b"OPENSSH", b"OpenSSH", x"6974e28099732061206d697373696f6e2120526570726573656e746564206279206120717569726b7920666f75722d657965642066726f672c202446454620706c656467657320746f20646f6e61746520323025206f662069747320726576656e756520746f204f70656e53534820646576656c6f706d656e742c20737570706f7274696e67207365637572652c206f70656e2d736f7572636520636f6e6e656374697669747920746f6f6c732e204a6f696e20757320696e20626c656e64696e672066756e207769746820707572706f7365e2809462656361757365206576656e2066726f67732076616c756520656e6372797074696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731923412557.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPENSSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENSSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

