module 0x6f37664b3562a3966ddf816c60ffdfad442fc1494b3da5c29366732a84ad6af8::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"BlobFish", b"$Blob, the memecoin thats here to take the Sui Network by storm and leave everyone in stitches. Now imagine that blob stumbling onto the blockchain, wiggling its way through the crypto world, and causing a frenzy. Thats $Blob, a memecoin thats more than just a squishy face; its a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036793_82d9660507.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

