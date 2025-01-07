module 0x91d479941237d220dc762a8c7eaebf403dc10b3234c528fa9b487ed102900cc0::suipepesuilamander {
    struct SUIPEPESUILAMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPESUILAMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPESUILAMANDER>(arg0, 6, b"SuiPepeSuilamander", b"SuiPepeSuilamanders", b"meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilamanders_9946879be5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPESUILAMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPESUILAMANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

