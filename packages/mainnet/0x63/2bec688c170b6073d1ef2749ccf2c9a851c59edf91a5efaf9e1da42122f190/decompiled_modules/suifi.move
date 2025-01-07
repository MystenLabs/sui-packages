module 0x632bec688c170b6073d1ef2749ccf2c9a851c59edf91a5efaf9e1da42122f190::suifi {
    struct SUIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFI>(arg0, 9, b"SUIFI", b"Sui Finance", b"Sui Finance , ecosystem from sui network !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmVCCBe7aY9rYVGPcyanGS3R17uyXE4MwcZ3vwthAZKdgt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

