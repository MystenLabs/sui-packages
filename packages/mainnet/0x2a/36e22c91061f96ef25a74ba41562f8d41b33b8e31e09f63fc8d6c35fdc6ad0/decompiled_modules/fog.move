module 0x2a36e22c91061f96ef25a74ba41562f8d41b33b8e31e09f63fc8d6c35fdc6ad0::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 6, b"FOG", b"SUIFOG", b"Meet $FOG the degen frog who thrives in chaos. With eyes locked on volatile trends and a heart full of conviction, $FOG leaps into the unknown while others freeze in fear.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxqwei47mohyjtuc6wvgp6l7s37jhbx5gg5pvkmvavwbztuy4c3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

