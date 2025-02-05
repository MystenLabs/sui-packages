module 0x2855f078f591b5c82aa6e09d7a3a338972ff0d812a937c2f75248b8177a22a5e::ming {
    struct MING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MING>(arg0, 9, b"TES", b"TES", b"string", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.ap-southeast-1.amazonaws.com/nfts.steampunk.game/coins/steam.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MING>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MING>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MING>>(v2);
    }

    // decompiled from Move bytecode v6
}

