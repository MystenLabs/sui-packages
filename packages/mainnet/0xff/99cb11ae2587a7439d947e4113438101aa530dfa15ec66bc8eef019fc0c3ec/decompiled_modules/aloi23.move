module 0xff99cb11ae2587a7439d947e4113438101aa530dfa15ec66bc8eef019fc0c3ec::aloi23 {
    struct ALOI23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOI23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOI23>(arg0, 6, b"Aloi23", b"ALOi", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fewcha_4e24c2c955.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOI23>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOI23>>(v1);
    }

    // decompiled from Move bytecode v6
}

