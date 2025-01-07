module 0xd79c6691ec07e90533ffdc0eb3c33435068c443ea9fa278184b7738f86a37179::suistem {
    struct SUISTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTEM>(arg0, 6, b"SUISTEM", b"SUISTEM TOKEN", b"$SUISTEM is a Sui-based meme coin that's taking the crypto world by storm. With its unique features and strong community backings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUSITEM_e9c384f72c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

