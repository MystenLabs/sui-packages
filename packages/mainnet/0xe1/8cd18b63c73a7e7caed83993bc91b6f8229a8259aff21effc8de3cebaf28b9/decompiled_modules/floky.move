module 0xe18cd18b63c73a7e7caed83993bc91b6f8229a8259aff21effc8de3cebaf28b9::floky {
    struct FLOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKY>(arg0, 9, b"FLOKY", b"Floky", b"Inspired by the heavyweights Shiba and Floki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1513245668445499398/fAoaFqkY.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOKY>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

