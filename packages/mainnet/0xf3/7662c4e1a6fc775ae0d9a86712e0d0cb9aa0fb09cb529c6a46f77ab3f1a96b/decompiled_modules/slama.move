module 0xf37662c4e1a6fc775ae0d9a86712e0d0cb9aa0fb09cb529c6a46f77ab3f1a96b::slama {
    struct SLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAMA>(arg0, 6, b"SLAMA", b"Smokin' LLama", b"SMOKIN' EVERYDAY EVERY NIGHT WITH US TILL TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_030746_872546001d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

