module 0xaef75b35a506ea9ff9dc5df7f96907e77185fca463fe96bc00e10781ba7cc6a4::fubao {
    struct FUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBAO>(arg0, 6, b"FUBAO", b"Fu Bao", b"Inspired by Fu Bao, the first giant panda born in South Korea, living in China, and a beloved global icon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FUBAO_873ccbc8b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

