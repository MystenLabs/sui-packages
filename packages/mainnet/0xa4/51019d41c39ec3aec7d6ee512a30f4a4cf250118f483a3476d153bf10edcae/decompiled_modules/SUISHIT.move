module 0xa451019d41c39ec3aec7d6ee512a30f4a4cf250118f483a3476d153bf10edcae::SUISHIT {
    struct SUISHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIT>(arg0, 6, b"SUISHIT", b"SUISHIT", b"a shitcoin on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

