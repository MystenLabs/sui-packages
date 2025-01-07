module 0xf3b7c98db7f3464beebfaa9929daecd6897496142e3e4d0818abc41fc95d5b7e::chillpengu {
    struct CHILLPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPENGU>(arg0, 9, b"CHILLPENGU", b"Just A Chill Pengu", b"What can I say? I'm just a chill pengu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPHtfSfZHUFtqtxU9gs1jyeuVYyNJaYAsKMcDL45zK3tq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLPENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

