module 0x2e2ff17202b30d7f38b0e0959b8a6337279be53a36ea4fe4f712ef34b3bc4739::alan {
    struct ALAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAN>(arg0, 6, b"ALAN", b"The Creator of Ai", b"$ALAN, inspired by Alan Turing, the father of AI, is a token that celebrates the origins and transformative impact of artificial intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731524550019.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

