module 0xfd533b6b2410e933648854df3dacbeab018bb054c86c15995343be25b2dd012f::gempalmsuptogether {
    struct GEMPALMSUPTOGETHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMPALMSUPTOGETHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GEMPALMSUPTOGETHER>(arg0, 6, b"GEMPALMSUPTOGETHER", b"GEM STONE,PALMS UP TOGETHER", b"SuiEmoji Gem Stone,Palms Up Together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/gempalmsuptogether.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GEMPALMSUPTOGETHER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMPALMSUPTOGETHER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

