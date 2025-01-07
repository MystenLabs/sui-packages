module 0x8f603b1908a198c9e3db8de39178a720fcddd8a9e6a7747128f1ef877e2fb4eb::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GUN>(arg0, 6, b"GUN", b"PISTOL", b"SuiEmoji Pistol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/gun.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

