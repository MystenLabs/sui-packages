module 0x1c95ddeae46ba825eca746aa7fba44218f0fc3ed62ec2911d4b96d47cb1c5b41::slen {
    struct SLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEN>(arg0, 9, b"SLEN", b"SuitosiLEN", b"Suitoshi Revealed on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/973c9544-9a70-44d7-a594-fe91a6a17c23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

