module 0xce22624597fee72b17fe4e4ee3866b80d19e0723e188959757c4532e46ab6fae::zengen {
    struct ZENGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENGEN>(arg0, 6, b"ZENGEN", b"Zen Genesis", b"Brought to you by ZenFrogs, this stream is your gateway to finding balance. Whether you're studying, working, or just need to relax, these carefully curated tracks will help you stay Zen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748262305691.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZENGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

