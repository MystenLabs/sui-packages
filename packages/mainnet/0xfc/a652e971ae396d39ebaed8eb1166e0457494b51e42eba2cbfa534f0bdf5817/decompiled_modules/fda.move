module 0xfca652e971ae396d39ebaed8eb1166e0457494b51e42eba2cbfa534f0bdf5817::fda {
    struct FDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDA>(arg0, 6, b"fda", b"fda", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FDA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

