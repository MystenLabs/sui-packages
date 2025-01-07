module 0xdab4cb579eb578ab0858209b9dbbc36dfe24ce5a73c0a677e8a195a5f8829e11::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"D.O.G.E.", x"4465706172746d656e74204f6620476f7665726e6d656e7420456666696369656e6379200a0a54686520676f7665726e6d656e74207765206e65656420f09f92aaf09f92aaf09f92aa207769746820456c6f6e204d75736b2021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731677150886.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

