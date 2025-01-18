module 0x669ac6fe8247ba81fa301cef37686adbfe587de2897d918ff3e2b9e904be3b7e::trumpao {
    struct TRUMPAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPAO>(arg0, 6, b"TrumpAO", b"Trump Alpha Omega", b"The tsunami is coming!!!! All socials will be posted tomorrow!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6190_de3abc55e7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

