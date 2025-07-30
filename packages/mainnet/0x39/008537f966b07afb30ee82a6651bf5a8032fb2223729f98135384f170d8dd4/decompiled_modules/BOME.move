module 0x39008537f966b07afb30ee82a6651bf5a8032fb2223729f98135384f170d8dd4::BOME {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 6, b"BOok of Memes", b"BOME", x"41206d656d6520636f696e20696e73706972656420627920746865206c6567656e646172792027426f6f6b206f66204d656d657327e28094776865726520766972616c2068756d6f72206d6565747320646563656e7472616c697a65642066696e616e63652e20424f4d452063656c6562726174657320696e7465726e65742063756c74757265207769746820612076696272616e7420636f6d6d756e6974792c206d656d652d706f7765726564207574696c6974792c20616e6420656e646c657373206c61756768732e204d656d6520686172642c20686f646c2068617264657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/o1yy57MrCL6CFVLtaMatNqOkg9EFv15Dod2JznRlGkw45fiKA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

