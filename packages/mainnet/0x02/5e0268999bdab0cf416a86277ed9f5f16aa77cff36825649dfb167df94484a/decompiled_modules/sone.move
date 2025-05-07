module 0x25e0268999bdab0cf416a86277ed9f5f16aa77cff36825649dfb167df94484a::sone {
    struct SONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONE>(arg0, 6, b"SONE", b"SuiOne", b"The Rise of SU1.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaexlx3yg5bed6cexfqmcr6krtcvh7wekz2sgur76ctdzrwyh3za4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SONE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

