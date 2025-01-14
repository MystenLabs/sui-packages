module 0x6f5eb0424e46d109828a66e802fe6f8ec67bf654d6abde74d9484b14158495e8::goldstein {
    struct GOLDSTEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDSTEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDSTEIN>(arg0, 9, b"goldstein", b"goldstein", b"goldsteinn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDSTEIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDSTEIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDSTEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

