module 0xcd507e23a849dda231b0eafa0b29fdeacdf3871d1d69654742b254c5c36dfa3b::sotto {
    struct SOTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTO>(arg0, 9, b"SOTTO", b"Sotto", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOTTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

