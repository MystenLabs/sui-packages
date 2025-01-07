module 0x60ca9b1033c0c5585467628b897730501a6390e1b71fd788b99fc0b59f67d1d1::cybercat {
    struct CYBERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT>(arg0, 9, b"CYBERCAT", b"Cyber cat", b"Cyber cat is a good token, it is useable by everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3062880d-7d78-4e83-85ca-2e356e0dfcf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

