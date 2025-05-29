module 0x7c6df8b99977538face6fe1e825c100e641b9d67e84b435d91ee66c47b55ea8::lavie {
    struct LAVIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAVIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAVIE>(arg0, 6, b"LAVIE", b"Lavie see me em", b"Mai see me em", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/5bf5e58f-fc0a-431c-86cb-2f0700f9c981.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAVIE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAVIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAVIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

