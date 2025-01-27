module 0xb4dfc34287360847dffa53ea095ad79642b44c2ac9def609b873fad07d939d11::dss {
    struct DSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSS>(arg0, 6, b"DSS", b"DeepSeek on Sui Meme", b"DeepSeek's first meme token on the Sui network. The meeting of the King of the Seas, Sui, with the Brain of the Seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000100664_5517c0f7d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

