module 0x30f14d55ff55a64de5cc3294dc94209ba85d6a3186b64e2773390004586b16a5::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 9, b"JOKER", b"Sui Joker AI", b"Joker AI on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/hXhtYvw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOKER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

