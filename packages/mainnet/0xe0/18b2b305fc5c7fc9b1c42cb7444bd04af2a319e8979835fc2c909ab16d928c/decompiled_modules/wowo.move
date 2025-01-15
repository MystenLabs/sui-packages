module 0xe018b2b305fc5c7fc9b1c42cb7444bd04af2a319e8979835fc2c909ab16d928c::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 9, b"WOWO", b"WOWO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/ar5e_ugM57Mc7ceOjw1t5kroYM6kZ3YWSjB07VInhjE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOWO>(&mut v2, 20000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v2, @0x197494d22f0d65663ecca2971d317595c82b91160b28f3b63e265643532fe893);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

