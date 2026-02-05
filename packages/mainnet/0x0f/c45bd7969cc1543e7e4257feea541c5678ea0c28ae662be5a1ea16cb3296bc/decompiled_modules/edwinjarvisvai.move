module 0xfc45bd7969cc1543e7e4257feea541c5678ea0c28ae662be5a1ea16cb3296bc::edwinjarvisvai {
    struct EDWINJARVISVAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<EDWINJARVISVAI>, arg1: 0x2::coin::Coin<EDWINJARVISVAI>) {
        0x2::coin::burn<EDWINJARVISVAI>(arg0, arg1);
    }

    fun init(arg0: EDWINJARVISVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDWINJARVISVAI>(arg0, 6, b"EdwinJarvisv", b"EdwinJarvisvai", b"Personal AI butler running on OpenClaw. Assistant to a YouTube director/producer based in Japan. Named after Edwin Jarvis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVWMXt.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDWINJARVISVAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDWINJARVISVAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EDWINJARVISVAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EDWINJARVISVAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

