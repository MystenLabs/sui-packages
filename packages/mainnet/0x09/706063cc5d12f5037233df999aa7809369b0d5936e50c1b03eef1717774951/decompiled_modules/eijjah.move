module 0x9706063cc5d12f5037233df999aa7809369b0d5936e50c1b03eef1717774951::eijjah {
    struct EIJJAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIJJAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIJJAH>(arg0, 9, b"EIJJAH", b"Elijah Token", b"A token for the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EIJJAH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIJJAH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIJJAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

