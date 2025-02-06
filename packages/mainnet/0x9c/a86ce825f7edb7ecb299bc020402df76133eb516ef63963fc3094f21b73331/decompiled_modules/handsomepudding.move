module 0x9ca86ce825f7edb7ecb299bc020402df76133eb516ef63963fc3094f21b73331::handsomepudding {
    struct HANDSOMEPUDDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANDSOMEPUDDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDSOMEPUDDING>(arg0, 4, b"HandsomePudding", b"HandsomePudding", b"this is HandsomePudding", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDSOMEPUDDING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANDSOMEPUDDING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

