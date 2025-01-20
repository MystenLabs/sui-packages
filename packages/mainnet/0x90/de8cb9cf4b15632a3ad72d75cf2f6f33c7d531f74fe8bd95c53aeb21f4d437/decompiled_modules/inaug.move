module 0x90de8cb9cf4b15632a3ad72d75cf2f6f33c7d531f74fe8bd95c53aeb21f4d437::inaug {
    struct INAUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: INAUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INAUG>(arg0, 9, b"INAUG", b"Official Inauguration Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUxUeJkCxrEhuAcenJvYFdp5BhGPJD3aYZuJnUF5ZC7Dz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INAUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INAUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INAUG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

