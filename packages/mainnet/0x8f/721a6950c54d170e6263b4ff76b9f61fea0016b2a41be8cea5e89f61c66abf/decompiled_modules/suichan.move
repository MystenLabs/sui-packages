module 0x8f721a6950c54d170e6263b4ff76b9f61fea0016b2a41be8cea5e89f61c66abf::suichan {
    struct SUICHAN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUICHAN", b"SUI CHAN", b"HEEEEEEEEYA! SUI CHAN HEEEEEEEEYA YA YA YAAAAA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.search.brave.com/3D_kGi7o8cquRPat-f6xKxrmgGdg8aEMQXxMvHsjWt0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJzLmNvbS9p/bWFnZXMvZmVhdHVy/ZWQvamFja2llLWNo/YW4tdWl5MzFtN2l5/OWpodnR4ci5qcGc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUICHAN>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUICHAN>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

