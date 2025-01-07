module 0x1b2b1a11438cef46f3cb6cfe39ab35ce6680ba2eb5b2f671e1678b4631af271::frogie {
    struct FROGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGIE>(arg0, 9, b"Frogie", x"46726f67696520f09f90b8", b"The OG Sui Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842178516865171456/4bDRaTif_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROGIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

