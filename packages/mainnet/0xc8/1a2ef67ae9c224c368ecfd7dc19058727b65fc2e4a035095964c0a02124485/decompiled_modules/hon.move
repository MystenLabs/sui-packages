module 0xc81a2ef67ae9c224c368ecfd7dc19058727b65fc2e4a035095964c0a02124485::hon {
    struct HON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HON>(arg0, 9, b"HON", b"HONEY", b"Fun Purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43cbde44-05e9-4664-bd24-69dd918cbc05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HON>>(v1);
    }

    // decompiled from Move bytecode v6
}

