module 0xb9ef5e574fc8fe66851144b0ca414040f8cf0394cab79bc8e2e167b91bba4f90::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 9, b"MYRO", b"MYRO on SUI", b"MYRO is a top doge on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dli4c64vxmhocabj7z4vzfxk4bl3k5dy4xsutljep5owx3plubcq.arweave.net/GtHBe5W7DuEAKf55XJbq4Fe1dHjl5UmtJH9da-3roEU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYRO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

