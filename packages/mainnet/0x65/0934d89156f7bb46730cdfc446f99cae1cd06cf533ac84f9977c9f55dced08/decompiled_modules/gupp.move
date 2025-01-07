module 0x650934d89156f7bb46730cdfc446f99cae1cd06cf533ac84f9977c9f55dced08::gupp {
    struct GUPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPP>(arg0, 6, b"GUPP", b"Gupp", x"47757070206973206e6f74206c696b65206f7468657220666973682e2048652077616e747320746f20626520746865206e756d6265722031206d656d6520636f696e20696e2074686520776f726c642e2074686973206d656d6520636f696e2077696c6c206e6f742062652073746f7070656420696e2069747320706174682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725027802763_3378354b688c20f9db00134374e49194_910e393e12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

