module 0x1f9eacf434eaca4f144fa3b50cb9813aa1d0c486b9ec88b0e0b140807449a48f::xmass {
    struct XMASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASS>(arg0, 6, b"XMASS", b"CHILLXMASS SUI", b"I'mma kinda chill guy who's enjoying the launch on water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_03_17_27_50_439094d5d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

