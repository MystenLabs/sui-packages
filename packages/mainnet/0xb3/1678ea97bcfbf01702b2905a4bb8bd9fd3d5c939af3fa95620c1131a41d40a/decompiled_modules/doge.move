module 0xb31678ea97bcfbf01702b2905a4bb8bd9fd3d5c939af3fa95620c1131a41d40a::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"Department of Government Efficiency", b"Department of Government Efficiency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmQfT9X1RETac7G3CDYRwyruFsJoTDybv7QVPe7boQSFiP"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 1000000000000000000, @0x508f99430a63fe4c1f3d1236ce2cda85bd29d7c90a1b94fe95e23f9dd0800864, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

