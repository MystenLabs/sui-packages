module 0x7e85942505378146571c35271486370d5c13173cf5d6e26da8f0899735465b61::greed {
    struct GREED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREED>(arg0, 6, b"GREED", b"Greed", b"Fully unleash the potential of your inner Degen with GREED on Sui. You know you want a 1000x. Be Greedy to get it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736019146833.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

