module 0x7001ac7a22cb5584cc11e4b5bd212ac5f92eb10b9255dce16cfeafc056b47bc7::trmpwn {
    struct TRMPWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMPWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMPWN>(arg0, 6, b"TRMPWN", b"TRUMPWIN", b"Trump Win a meme token inspired by the controversial figure, Donald Trump, is ready to make a splash on the Sui network! Only a few days left until we await Trump's absolute victory!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asfafwf_edcee415a1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMPWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMPWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

