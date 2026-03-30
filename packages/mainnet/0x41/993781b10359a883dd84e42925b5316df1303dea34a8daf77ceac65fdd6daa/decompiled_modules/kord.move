module 0x41993781b10359a883dd84e42925b5316df1303dea34a8daf77ceac65fdd6daa::kord {
    struct KORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORD>(arg0, 6, b"KORD", b"KORD", b"KORD on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KORD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

