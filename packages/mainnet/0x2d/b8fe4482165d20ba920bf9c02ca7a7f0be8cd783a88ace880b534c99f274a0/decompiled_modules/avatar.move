module 0x2db8fe4482165d20ba920bf9c02ca7a7f0be8cd783a88ace880b534c99f274a0::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"AVATARSUI", b"AVATAR ON HIS WHAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjcgtfwatwvdo6ubcj65ou7wjb7dsknbf3j5h47gwlop5ani5gwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AVATAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

