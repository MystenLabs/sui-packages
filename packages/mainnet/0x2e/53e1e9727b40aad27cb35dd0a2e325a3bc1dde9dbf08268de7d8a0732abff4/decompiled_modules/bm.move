module 0x2e53e1e9727b40aad27cb35dd0a2e325a3bc1dde9dbf08268de7d8a0732abff4::bm {
    struct BM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BM>(arg0, 9, b"BM", b"BLUM", b"Blum Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f1f48e85512112b99e7ad12ef32fbc1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

