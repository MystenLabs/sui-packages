module 0xacf7f41c3a132adb5c6293659354cefb1d87fb023ca93b5a56f88c820a1911a7::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"LOVE ON SUI", b"LOVE - launched to celebrate Valentines Day and the power of love in crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbqqxTPk3Ud4pwFbYmREPj3RvHrFD8M93or88TVRAhNZj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

