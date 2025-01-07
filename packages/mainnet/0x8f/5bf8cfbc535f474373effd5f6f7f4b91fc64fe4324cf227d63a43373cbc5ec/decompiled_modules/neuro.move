module 0x8f5bf8cfbc535f474373effd5f6f7f4b91fc64fe4324cf227d63a43373cbc5ec::neuro {
    struct NEURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURO>(arg0, 9, b"NEURO", b"Neuroti Cat", b"Neuro Sui Drunk Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1814714519148466176/MvGj1kih_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEURO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

