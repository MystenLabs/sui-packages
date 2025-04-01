module 0xd8efd97d3e9feeff35397209ad1173af5956fa0f229919997dd05f312191c761::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"CS", b"catsleep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicb73yc7w7mzfkwbvszkwd7x2ublqm3q6muzgwycs5uflimldmhay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v2, @0x45c5b4a44b7f0411b661b677d2816d04c972d8fc4a0c79ca83dc10cc4827d5fe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v1);
    }

    // decompiled from Move bytecode v6
}

