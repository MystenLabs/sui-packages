module 0xb0236f7e9234c995cda5b6ee02add27bd1dc12a5af85ea51b515a6b68f21ac51::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 6, b"HOPE", b"HOPE", b"HOpe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/0214c5f1-80df-4515-925f-5ad1702eb0ad.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

