module 0xd2d3619e04b9bd89ac46e7e58b8f1bc71f56c7b4727fb0c83ccb825c7b02c183::noodlehorn {
    struct NOODLEHORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLEHORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLEHORN>(arg0, 9, b"NOODL", b"Noodlehorn", b"The only unicorn who's clumsy, bendy, and obsessed with crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihz6cre5xmzhnqf5ccq54lk2a5e5x2vqrf3uubyzk7mprthhr3zvy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOODLEHORN>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLEHORN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOODLEHORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

