module 0xb6df5dc129a3fe163f40b494055854e41e0609c19c62e03cb8ed38183506c037::sray {
    struct SRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAY>(arg0, 6, b"SRAY", b"Silly Ray", b"$SRAY the Stingray used to chill in coral reefs. One day he touched Sui and became a crypto legend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091413_5211c72cc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

