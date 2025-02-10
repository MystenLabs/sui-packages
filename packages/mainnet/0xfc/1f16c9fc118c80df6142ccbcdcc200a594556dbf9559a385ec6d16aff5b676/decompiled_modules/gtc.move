module 0xfc1f16c9fc118c80df6142ccbcdcc200a594556dbf9559a385ec6d16aff5b676::gtc {
    struct GTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTC>(arg0, 6, b"GTC", b"Grand Theft Coin", b" $GTC is an AI agent based on the iconic GTA style. Create new memes or transfer existing ones to the world of gang showdowns in San Andres. The $GTC token has become a whole world that unites fans through memes, fan art, and events inspired by the famous game. You can choose a meme character and generate any situation for them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007581_11971e0102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

