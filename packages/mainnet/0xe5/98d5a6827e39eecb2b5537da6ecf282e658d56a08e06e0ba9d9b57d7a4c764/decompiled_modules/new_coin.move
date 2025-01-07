module 0xe598d5a6827e39eecb2b5537da6ecf282e658d56a08e06e0ba9d9b57d7a4c764::new_coin {
    struct NEW_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_COIN>(arg0, 6, b"ALLFATHER", b"AllFather of the SUI devs", b"ALLFATHER of Sui devs, he thinks he's Odin but codes in Move. He's got the whole blockchain wrapped around his finger, or at least he'd like you to think so with his divine tech wisdom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1821959939197177858/1QiIq0i3_400x400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEW_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

