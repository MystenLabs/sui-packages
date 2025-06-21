module 0x7084100d964b81ad1eead3629fb7d87dbd548d1b0ee1306f0f5b2bf823da241::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 6, b"MNT", b"Minati", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/e560eb9c-4e99-4f4a-aad8-b77bcf2284c9.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MNT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

