module 0x77dc003124a75cb2b0cad160191e42d6909a33d6d14295b8fe8ecf5b7ce5a31::cybercat {
    struct CYBERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT>(arg0, 9, b"CYBERCAT", b"Cyber cat", b"Cyber cat is a good token, it is useable by everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87836a8d-6352-4f73-a790-14b5880773f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

