module 0x56bbd33239b26fdb035c0df91b927a699f2b95b0187cf9c7883b58bd90913423::froui {
    struct FROUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROUI>(arg0, 6, b"FROUI", b"Frog On Sui", b"First Frog On SUI, No Utility just gonna be a ninja's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000210686_9faecd32d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

