module 0x802d89c2071e7b34ad1c4cea07ec875211108262718643c6934a4e41c1cf83fa::suifunnypes {
    struct SUIFUNNYPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUNNYPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUNNYPES>(arg0, 6, b"SuiFunnyPes", b"FunnyPes", x"627579206d7920746f6b656e210a6c75636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/211_ef5ce1a4b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUNNYPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUNNYPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

