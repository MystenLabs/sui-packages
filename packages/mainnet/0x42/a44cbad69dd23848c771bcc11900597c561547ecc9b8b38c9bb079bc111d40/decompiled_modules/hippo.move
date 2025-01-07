module 0x42a44cbad69dd23848c771bcc11900597c561547ecc9b8b38c9bb079bc111d40::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", b"HIPPO is the new future", b"HIPPO on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/616b2c72c5848304bf335535/616d0836910205a556029675_Hippo-6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

