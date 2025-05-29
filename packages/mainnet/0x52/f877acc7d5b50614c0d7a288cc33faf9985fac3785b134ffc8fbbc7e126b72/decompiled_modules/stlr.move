module 0x52f877acc7d5b50614c0d7a288cc33faf9985fac3785b134ffc8fbbc7e126b72::stlr {
    struct STLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STLR>(arg0, 9, b"STLR", b"Stellar", b"Stellar coin meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f1673fbd6c3ccc0ec99ac33783786804blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STLR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STLR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

