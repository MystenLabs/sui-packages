module 0x1c02ea15c9fac6524bb3da9a708cf0bb88ccd244248e29b08e08e8dd87a53a58::dkt {
    struct DKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKT>(arg0, 8, b"DKT", b"dKloud", b"We connect DePIN Ecosystem with Enterprise market opportunities.  dKloud helps customers Build Better Software and more Efficiently through our products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/2d4c2b80-6e2c-44dc-b95b-52eb6b5b5abd.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DKT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

