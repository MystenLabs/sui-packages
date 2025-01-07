module 0xd1dc5d29c92e085b4b2d8fc175e5e6dbd5e380cac431bbe807682b360c24895f::dxt {
    struct DXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXT>(arg0, 9, b"DXT", b"DEXIT", b"Meme game utility token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd6d4d95-7ac0-46b2-ab63-61c54aea2cb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

