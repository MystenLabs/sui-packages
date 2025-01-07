module 0x90ca9c47458e18cc8d04452d13797c09c151b310bc6e792026362e656e875859::wewecat {
    struct WEWECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWECAT>(arg0, 9, b"WEWECAT", b"WEWE", b"WEWE token is a cryptocurrency named after characters, individuals, animals, artwork, or anything else in an attempt to be humorous, light-hearted, and attract a user base by promising a fun community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79ec2944-a35c-474d-84ce-456623b3d0e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

