module 0x74a849515180d22e532147c30afd30a2ff5d59ad8e351bd72a75cdfdbf39f23d::bwe {
    struct BWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWE>(arg0, 9, b"BWE", b"Bwewe", b"Dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dcea8b0-0167-4c7b-9848-077747206bce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

