module 0x283da39aa8bd1d396de422ee368dbf7c73202a28d063ee2c6e7466b0ea89aa8f::babytrumpp {
    struct BABYTRUMPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMPP>(arg0, 6, b"Babytrumpp", b"Babytrump", b"Introducing $BABYTRUMP, a memecoin that transcends the traditional seriousness of crypto with a playful twist on presidential prowess all while laying waste to the corrupt antics of the Demoncrats. Picture a pint-sized version of Donald Trump navigat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000408979.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTRUMPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

