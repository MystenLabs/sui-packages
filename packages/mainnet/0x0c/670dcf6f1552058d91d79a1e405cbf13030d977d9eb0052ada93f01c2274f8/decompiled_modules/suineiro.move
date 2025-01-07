module 0xc670dcf6f1552058d91d79a1e405cbf13030d977d9eb0052ada93f01c2274f8::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 9, b"SuiNeiro", b"SuiNeiro", b"$SuiNeiro. The new Shiba Inu dog, successor to the Doge dog after her passing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/Qmb1HCvLSWzyCXCASFpbD2hFStD9RzrXBAUvmF3CPrXiCc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

