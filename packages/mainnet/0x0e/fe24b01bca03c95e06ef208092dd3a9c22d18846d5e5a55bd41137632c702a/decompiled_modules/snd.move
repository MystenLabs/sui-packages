module 0xefe24b01bca03c95e06ef208092dd3a9c22d18846d5e5a55bd41137632c702a::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"Snopdy", b"Token for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f1179b8-95c3-4434-a181-ab262b55aac2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

