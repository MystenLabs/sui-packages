module 0xb767f12a422c180e0647b985914f9ea5ddaf856308d11a19c6283389e2f27ed7::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 9, b"SUIMON", b"Sui Doraemon", b"Sui Doraemon, Your Crypto Journey Begins with a Gadget Full of Fun!   // https://t.me/suidoraemon // https://www.suimon.fun/ // https://x.com/suidoraemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728919176954-7575db7151f63821f5a2388d9b2a7912.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMON>(&mut v2, 350000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v2, @0x8939dc7310c96f3d0e2a73d4e78075f97980f7b9c2c39835d67b055755588ec3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

