module 0x9215ca51fa90436a188a145f780141d718bd3c74c7503017b04b182f8300f994::turbobear {
    struct TURBOBEAR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURBOBEAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TURBOBEAR>>(0x2::coin::mint<TURBOBEAR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TURBOBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOBEAR>(arg0, 6, b"Beta", b"Beta", b"Beta Test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOBEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOBEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

