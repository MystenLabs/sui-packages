module 0xfee848222308bff7da77edb64f4fa65c4e6a4188d963a470f2ca45d06f20d691::dogfun {
    struct DOGFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGFUN>(arg0, 6, b"Dogfun", b"Just Dogs having fun", b"Dogfun ($Dogfun) has all the elements to trigger a bull run by bringing new degen on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956166027.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

