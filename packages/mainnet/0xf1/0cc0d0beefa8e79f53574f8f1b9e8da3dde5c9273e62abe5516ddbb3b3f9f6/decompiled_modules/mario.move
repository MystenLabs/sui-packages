module 0xf10cc0d0beefa8e79f53574f8f1b9e8da3dde5c9273e62abe5516ddbb3b3f9f6::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"SUPER MARIO BROS", x"5355504552204d4152494f2042524f53200a457870657269656e63652074686520636c6173736963204e696e74656e646f20616476656e7475726520696e20796f75722062726f777365722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7xda4bss2w5m7jdzb4xjgu7s4lnp6cqdzq7esjsx67o2gmlavtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

