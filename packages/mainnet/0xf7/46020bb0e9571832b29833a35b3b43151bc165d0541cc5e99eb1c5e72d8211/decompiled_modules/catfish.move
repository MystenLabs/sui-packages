module 0xf746020bb0e9571832b29833a35b3b43151bc165d0541cc5e99eb1c5e72d8211::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"Catfish", b"CATFISH TOKEN", b"a catfish meme completely from the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731933480551.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

