module 0x2c020a9ec1931490ef7de78647bd6b5d1e32f76a0cd73c210a43c156cdc7934d::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 6, b"SFOX", b"Suifox", b"SuiFox is the agile fox of the SUI network, ready to bring excitement and speed into the world of meme coins. Known as a clever digital scout, SuiFox leaps from one block to another, leaving a trail of bravery and joy in every step.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoss_161518cedf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

