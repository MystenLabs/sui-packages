module 0x60d3a13769aa7cc62138dcfa3145e122804d23bfc0923c61b1c565a665974217::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 9, b"MCGA", b"Make Crypto Great Again", b"The Hat Movement on the Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xba2127f18fde035aa656ae2c7404ac2e49345f14.png?size=lg&key=4ae065")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

