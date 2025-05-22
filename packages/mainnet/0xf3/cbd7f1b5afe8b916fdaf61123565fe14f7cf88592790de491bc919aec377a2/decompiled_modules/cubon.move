module 0xf3cbd7f1b5afe8b916fdaf61123565fe14f7cf88592790de491bc919aec377a2::cubon {
    struct CUBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUBON>(arg0, 6, b"CUBON", b"CuBone", b"The Legendary Meme Token on SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib33zgja6u5wm3zi3t2bxxb2ev2fnwwklovgtj56net4kznkzhzja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUBON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUBON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

