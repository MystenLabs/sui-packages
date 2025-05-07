module 0xff905f1fdc0b7e05a3c983f9385e0871c774fe8f7ab8d017669628e02b1ef5cf::puddlepop {
    struct PUDDLEPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDLEPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDLEPOP>(arg0, 9, b"PUDDY", b"Puddlepop", b"Every dip is a splash! Puddlepop jumps in feet-first, makes a mess, and somehow finds treasure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibemv2m4tvbtpciltovobmfyixqoj2dirj6rrgvqhikooj73sizuq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUDDLEPOP>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDLEPOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDDLEPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

