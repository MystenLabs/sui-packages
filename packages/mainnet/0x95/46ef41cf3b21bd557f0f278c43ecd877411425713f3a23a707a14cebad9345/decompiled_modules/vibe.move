module 0x9546ef41cf3b21bd557f0f278c43ecd877411425713f3a23a707a14cebad9345::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBE>(arg0, 6, b"Vibe", b"J wanna vibe", b"Aight, lemme hit you with the real deal, mfs like you find this coin, Vibe, really interesting, bro. It's all about that personal vibe, you get what I'm sayin'? This lil' creature on the coin, he's just chillin', lookin' like he's got no worries, uk what I mean bro? just $vibe like lil bro here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_164606_751_073363a38b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

