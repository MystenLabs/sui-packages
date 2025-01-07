module 0x134f95549495d58019b7c6747e5156f4d27708d70fae8c5e27eb6d701ad3340e::sshib {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SShib", b"SuiShib", b"Just Shiba on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_113210_097_5b4cb225b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

