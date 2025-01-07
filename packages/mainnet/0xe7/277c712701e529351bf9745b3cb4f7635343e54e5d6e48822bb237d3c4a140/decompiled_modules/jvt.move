module 0xe7277c712701e529351bf9745b3cb4f7635343e54e5d6e48822bb237d3c4a140::jvt {
    struct JVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JVT>(arg0, 4, b"JVT", b"Jarvis_Token", b"JVT (Jarvis_Token) is the proprietary cryptocurrency designed to facilitate and optimize transactions within our AI trading bot ecosystem. It offers users a seamless, secure, and efficient way to access premium trading services, pay for transaction fees, and reward community engagement. JVT leverages blockchain technology to ensure transparency and immutability, providing users with confidence in the integrity of their trades. Additionally, holding JVT unlocks advanced features and analytics, empowering traders to maximize their investment potential through our sophisticated AI-driven algorithms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jarvistoken.online/logoJVT.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JVT>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JVT>>(v2, @0x90416b69e66c1be8963a21aa967862a96692677a8654c4b8fc3a1d1be0d2340e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

