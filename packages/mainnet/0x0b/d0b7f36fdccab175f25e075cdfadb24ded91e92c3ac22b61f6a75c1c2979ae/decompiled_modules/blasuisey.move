module 0xbd0b7f36fdccab175f25e075cdfadb24ded91e92c3ac22b61f6a75c1c2979ae::blasuisey {
    struct BLASUISEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASUISEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASUISEY>(arg0, 9, b"BLASUI", b"Blasuisey", b"A round, pink nurse monster balancing eggs decorated with the Sui logo, spreading wholesome meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASUISEY>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASUISEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASUISEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

