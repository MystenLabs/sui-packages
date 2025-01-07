module 0x2e29ee6d9c6174ae81487be03d1dae13bf764f7ded394afb9ea2021f10965865::cybercat {
    struct CYBERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT>(arg0, 9, b"CYBERCAT", b"Cyber cat", b"Cyber cat is a good token, it is useable by everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bede2cdd-46c2-4ddc-9999-5c746a696652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

