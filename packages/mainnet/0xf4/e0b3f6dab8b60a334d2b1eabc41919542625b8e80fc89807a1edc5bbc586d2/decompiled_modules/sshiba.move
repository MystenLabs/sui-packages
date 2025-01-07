module 0xf4e0b3f6dab8b60a334d2b1eabc41919542625b8e80fc89807a1edc5bbc586d2::sshiba {
    struct SSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIBA>(arg0, 9, b"SSHIBA", b"SleepyShib", b" Take a nap while your portfolio grows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85bc4ef8-84ad-4a91-a6c9-beb8ea3cbafa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

