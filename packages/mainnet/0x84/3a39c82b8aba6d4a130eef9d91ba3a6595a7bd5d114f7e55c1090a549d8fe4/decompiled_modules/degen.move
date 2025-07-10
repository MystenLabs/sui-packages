module 0x843a39c82b8aba6d4a130eef9d91ba3a6595a7bd5d114f7e55c1090a549d8fe4::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"DEGEN", b"DEGENS OF BONK", b"Made by degens for degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmZVLDVPgT3rHiSqQ61R5HdtjjhBDVkKfFUpWUHWvKqPyZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

