module 0xd0fd1c33445f1b8af1c47bb5956d0982ed0ccb53d68f54ef9c584974e4ee57fc::droplet {
    struct DROPLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DROPLET>(arg0, 6, b"DROPLET", b"DROPLET", b"SuiEmoji Droplet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/droplet.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DROPLET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPLET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

