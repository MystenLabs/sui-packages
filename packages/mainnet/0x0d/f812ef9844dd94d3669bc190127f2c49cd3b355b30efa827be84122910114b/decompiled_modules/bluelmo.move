module 0xdf812ef9844dd94d3669bc190127f2c49cd3b355b30efa827be84122910114b::bluelmo {
    struct BLUELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUELMO>(arg0, 6, b"BluElmo", b"BluElmo Sui", b" Coming from the world of unknown. BluElmo was born! Lalalala lalalala, Elmo's world! Lalalala lalalala, Elmo's world! Elmo loves his goldfish, his crayons too Dadada, That's elmo's WORLD!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_04_30_58_0daf7080f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

