module 0xd658a5a26528b4ab986bb9aa2c89913c11b79fc56b21ac823376fe2aa7c9d785::spup {
    struct SPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUP>(arg0, 5, b"spup", b"seal pup", b"seal or pup?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sapphire-worthwhile-sailfish-762.mypinata.cloud/ipfs/QmRzmwkXKakSzvZ5GP9TvhbYNifTb5z7rcFowH9x17N2a3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPUP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

