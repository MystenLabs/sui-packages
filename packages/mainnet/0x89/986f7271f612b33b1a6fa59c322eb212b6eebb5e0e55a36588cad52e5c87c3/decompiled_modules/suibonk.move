module 0x89986f7271f612b33b1a6fa59c322eb212b6eebb5e0e55a36588cad52e5c87c3::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBONK>(arg0, 9, b"SUIBONK", b"Sui Bonk", b"Bonk Is meme Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmRCpSYQPxDMDWxPziVEatmtn4xQtMBdXbzjSJM1VKcoe7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBONK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

