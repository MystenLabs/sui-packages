module 0x3086f72dbcebb3ebdca02919f232798febb4909eb8e6949d9f2a1f7f568eda48::vinit {
    struct VINIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINIT>(arg0, 9, b"vinit", b"Vinit Token", b"A token for the Vinit ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

