module 0x841318e2659b83660a43ba5518e149ad3d6f97ec7a1e57fa06e694e8a3b45b0a::xpay {
    struct XPAY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XPAY>, arg1: 0x2::coin::Coin<XPAY>) {
        0x2::coin::burn<XPAY>(arg0, arg1);
    }

    fun init(arg0: XPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPAY>(arg0, 9, b"XPAY", b"XPAY", b"XPAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmctHXPddLpiLWBXda5VbHFUZLqKtAYaJXDSbKPNzCuD5B")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XPAY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XPAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

