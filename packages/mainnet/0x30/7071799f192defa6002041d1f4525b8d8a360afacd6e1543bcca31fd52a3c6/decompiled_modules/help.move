module 0x307071799f192defa6002041d1f4525b8d8a360afacd6e1543bcca31fd52a3c6::help {
    struct HELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELP>(arg0, 6, b"Help", b"Help!!!", b"Hello, the purpose of creating this token is to alleviate extreme poverty, hard work, and lack of a completely simple life that my friends and I have longed for, which was the only possible way that came to our minds. If this token is exploited and developed and we earn capital, we will help many people in poverty, so that both we and they can be saved from this misery. Thank you and I humbly ask you to support us and our token. Thank you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241205_212749_568_d8af675654.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELP>>(v1);
    }

    // decompiled from Move bytecode v6
}

