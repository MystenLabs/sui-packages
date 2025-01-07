module 0x8e50c3714ede8177284091a1b8ad8dd4badd153f4ccf06172881efe69b665525::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 9, b"Super", b"Super Suitama", b"Suitama the strongest punch on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6c5f561d48e6a6d3a59762b85cdf3205blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

