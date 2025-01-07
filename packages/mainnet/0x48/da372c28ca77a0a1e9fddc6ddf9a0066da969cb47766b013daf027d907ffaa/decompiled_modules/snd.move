module 0x48da372c28ca77a0a1e9fddc6ddf9a0066da969cb47766b013daf027d907ffaa::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"SNOPPDY", b"Token meme for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d82fdf3-d0c3-47d7-bd20-f1bd3c39a165.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

