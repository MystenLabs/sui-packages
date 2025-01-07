module 0xc01f4549719e46f0792fd9e3d2fa5fd25439d4373e31efdcaf5eb52d2211ef2e::wmi {
    struct WMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMI>(arg0, 6, b"WMI", b"WE MADE IT", x"5745204d4144452049542e0a323032352e0a5066502066726f6d20676f6f676c652e204e6f2078202e204e6f2077656273697465200a477261746566756c20666f7220323032342e0a44657620776f6e742073656c6c202e204a757374206c65747320686176652066756e20646567656e732e204e6f2078313030302068657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0600_5ce30a6777.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

