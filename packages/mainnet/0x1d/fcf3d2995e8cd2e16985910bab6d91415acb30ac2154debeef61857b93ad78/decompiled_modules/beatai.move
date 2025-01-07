module 0x1dfcf3d2995e8cd2e16985910bab6d91415acb30ac2154debeef61857b93ad78::beatai {
    struct BEATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEATAI>(arg0, 6, b"BEATAI", b"eBeat AI", b"Revolutionizes the music creation process by combining the power of Al and Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735312192414.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEATAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEATAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

