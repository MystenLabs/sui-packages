module 0xe1f12b4681c66f9484ebf6acfe0f535e0eb60b1e41aef209c51287bc58bd230a::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OG>(arg0, 6, b"OG", b"Orange Grouper", b"OG, is an Orange Grouper in the form of Trump.Become part of the Orange Grouper Gang and Help OG defeat the deep sea tyrants of the Sui Block chain. HODL $OG!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_9f4f68b2b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OG>>(v1);
    }

    // decompiled from Move bytecode v6
}

