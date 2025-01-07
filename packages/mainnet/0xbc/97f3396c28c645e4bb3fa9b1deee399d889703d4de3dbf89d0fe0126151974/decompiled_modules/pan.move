module 0xbc97f3396c28c645e4bb3fa9b1deee399d889703d4de3dbf89d0fe0126151974::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"Pandora Finance", b"PAN is the native token of Pandora Finance ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-deep-leech-408.mypinata.cloud/ipfs/QmUZXr6W9bzuN6w6Q19RYBXWxAkMVr21tkStKXdF1uk5KX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAN>(&mut v2, 12222000000000000, @0x5838efe3c7802c387ed4ee30532544de33ed4bc68a74607b041707a22aa02700, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v2, @0x5838efe3c7802c387ed4ee30532544de33ed4bc68a74607b041707a22aa02700);
    }

    // decompiled from Move bytecode v6
}

