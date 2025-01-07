module 0xe08866836f6ec29453200eb1c5f26852263e6923691f6233d562d5113c3e449f::kjy {
    struct KJY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJY>(arg0, 9, b"KJY", b"Kojaywow", b"Channel Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcbe1032-c1e6-49c5-a491-9f335d863f44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJY>>(v1);
    }

    // decompiled from Move bytecode v6
}

