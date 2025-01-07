module 0x96841de8463324153946304da8d92829c9b04ff7d8fa2e667bd72ac95d6f8412::elgato {
    struct ELGATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELGATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELGATO>(arg0, 6, b"ELGATO", b"ELGATO on SUI", b"\"el gato\" is a misheard \"arigato\" (thanks) from an anime clip, popularized on TikTok in March 2022. It is linked with the standing cat, leading to its virality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ucq6q_y9_400x400_39bd6597e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELGATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELGATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

