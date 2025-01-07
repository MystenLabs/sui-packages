module 0x95603503f6e034e57ec479f065939eac9708a6515e4ef93a5d6e3ff65dc597bd::cdog {
    struct CDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDOG>(arg0, 6, b"Cdog", b"Sui cute dog", b"The cute dog memecoin on sui chian ,just enjoy it .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cute_dog_6d093063c8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

