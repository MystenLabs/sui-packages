module 0x12ff3176a8890620992137b5ea93240d0492de988cbf576810199faee16944f9::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"Blob On Sui", b"$Blob, the memecoin thats here to take the Sui Network by storm and leave everyone in stitches. Now imagine that blob stumbling onto the blockchain, wiggling its way through the crypto world, and causing a frenzy. Thats $Blob, a memecoin thats more than just a squishy face; its a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blob_logo_495677f199_8dc0c5ec64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

