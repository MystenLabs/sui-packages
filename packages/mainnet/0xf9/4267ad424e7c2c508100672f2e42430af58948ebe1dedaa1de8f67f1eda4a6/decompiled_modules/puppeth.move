module 0xf94267ad424e7c2c508100672f2e42430af58948ebe1dedaa1de8f67f1eda4a6::puppeth {
    struct PUPPETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPETH>(arg0, 6, b"PUPPETH", b"Puppeth on Sui", b"First Mascot of the Sui  Foundation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_WONA_Ak6_400x400_f2a1114a66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

