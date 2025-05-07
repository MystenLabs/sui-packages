module 0x9b3169c92105ddc0a41bad38fb2149942a392603d8e5e6a7b909ce899b53ec4::noodlehorn {
    struct NOODLEHORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLEHORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLEHORN>(arg0, 9, b"NOODL", b"Noodlehorn", b"The only unicorn who's clumsy, bendy, and obsessed with crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihz6cre5xmzhnqf5ccq54lk2a5e5x2vqrf3uubyzk7mprthhr3zvy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOODLEHORN>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLEHORN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOODLEHORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

