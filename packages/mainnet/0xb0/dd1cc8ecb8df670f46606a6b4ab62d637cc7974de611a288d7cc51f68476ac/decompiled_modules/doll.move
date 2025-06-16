module 0xb0dd1cc8ecb8df670f46606a6b4ab62d637cc7974de611a288d7cc51f68476ac::doll {
    struct DOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLL>(arg0, 6, b"DOLL", b"RAG", b"Ragdolls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/6249d12b-1b64-4851-a71d-5466a0e70536.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLL>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

