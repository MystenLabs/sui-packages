module 0x62f2b3f30f9255c456b4bbf04a22708f93724ca6e72fbc411023faa0f65395d8::ergophobia {
    struct ERGOPHOBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERGOPHOBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERGOPHOBIA>(arg0, 9, b"ERGOPHOBIA", b"Job Application Form", b"Run for your lives, It's a job application form.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BzXZ4zPy4FZrcAUgLJEK2e5qY9Vj8F8EjhSSodE1pump.png?size=xl&key=9a8769")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERGOPHOBIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERGOPHOBIA>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERGOPHOBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

