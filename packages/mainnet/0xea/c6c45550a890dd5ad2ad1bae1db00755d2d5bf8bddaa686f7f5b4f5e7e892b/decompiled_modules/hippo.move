module 0xeac6c45550a890dd5ad2ad1bae1db00755d2d5bf8bddaa686f7f5b4f5e7e892b::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", b"Hippo On Sui", b"Hi ~~~~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/2fc2f087-be89-481c-914a-391195d0f7a7.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

