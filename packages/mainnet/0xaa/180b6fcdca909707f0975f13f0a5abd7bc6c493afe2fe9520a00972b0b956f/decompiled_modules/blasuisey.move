module 0xaa180b6fcdca909707f0975f13f0a5abd7bc6c493afe2fe9520a00972b0b956f::blasuisey {
    struct BLASUISEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASUISEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASUISEY>(arg0, 9, b"BLASUI", b"Blasuisey", b"A round, pink nurse monster balancing eggs decorated with the Sui logo, spreading wholesome meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreie5uhllui6hu6ykshffu6dn5f3xo3jvfk7bvckmnkhm3oarx26y2u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASUISEY>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASUISEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASUISEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

