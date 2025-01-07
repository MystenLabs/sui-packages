module 0xb3fcaadbac41bf8f04a78d46f98941798173dd7d944fa994364f47e35c9df10::scow {
    struct SCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOW>(arg0, 6, b"SCOW", b"SUICOW", b"$SCOW is more than just a meme coin; its a community-powered phenomenon. Our mission is to create a welcoming space where everyone can contribute, collaborate, and have fun together. With $SCOW, were cultivating a supportive and engaging environment that thrives on the collective spirit of our herd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0c63c025_d3af_4478_97d1_6a54bd3cdc95_9a5fff0e47.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

