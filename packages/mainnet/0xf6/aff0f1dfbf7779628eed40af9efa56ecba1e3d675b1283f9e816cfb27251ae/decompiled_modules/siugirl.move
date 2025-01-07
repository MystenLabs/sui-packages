module 0xf6aff0f1dfbf7779628eed40af9efa56ecba1e3d675b1283f9e816cfb27251ae::siugirl {
    struct SIUGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUGIRL>(arg0, 9, b"SIUGIRL", b"Siu Girl", b"Siu Girl is Water Girl in Game 2d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmXU1vQ1TzuMoXT7adNigQ4Een1v6NBmBTf1ipMMqKvi2y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIUGIRL>(&mut v2, 366000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

