module 0x11e67e40a1867e912593c0950bc11192495257414da02fa55848408a52c225ce::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 6, b"HYPE", b"Hypememe", b"Hype meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/5cc5389c-e6ae-49a6-866e-7884d873a3c9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

