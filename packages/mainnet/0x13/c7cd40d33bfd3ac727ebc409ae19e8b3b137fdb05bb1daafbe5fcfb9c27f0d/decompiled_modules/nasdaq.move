module 0x13c7cd40d33bfd3ac727ebc409ae19e8b3b137fdb05bb1daafbe5fcfb9c27f0d::nasdaq {
    struct NASDAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDAQ>(arg0, 9, b"NASDAQ", b"Sui on NASDAQ", b"Imagine Sui listed on NASDAQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1294006403607257088/2wydGevv.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NASDAQ>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDAQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NASDAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

