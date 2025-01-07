module 0xc933ee3cb09806d68145655e9c4114b89d4dc7382a4f7457ce2eef5d25d5bd8b::torc {
    struct TORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORC>(arg0, 9, b"TORC", b"TORC", b"Thor Of Relevant Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/thumb/3/3c/Chris_Hemsworth_as_Thor.jpg/220px-Chris_Hemsworth_as_Thor.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORC>>(v1);
    }

    // decompiled from Move bytecode v6
}

