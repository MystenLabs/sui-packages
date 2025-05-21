module 0x7a49801c573a6b60754dff81b4e5451c45159b926cdf5fb6ea3d69a28f54b482::theads {
    struct THEADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEADS>(arg0, 9, b"THEADS", b"TestHeads", b"This is the best description on the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_682d16a6b185a4.02565497.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEADS>>(v1);
    }

    // decompiled from Move bytecode v6
}

