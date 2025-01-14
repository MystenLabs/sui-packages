module 0xf87ee99ac7a719c0a8f468c963dbaefb8b64e4b13d0a5470e83fdb0c5eaeb3e7::jbi {
    struct JBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JBI>(arg0, 6, b"JBI", b"Just buy it", x"4a757374206275792069742e0a0a4e6f20736f6369616c732e0a0a486f6c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JUST_BUY_IT_2_55cf50776c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

