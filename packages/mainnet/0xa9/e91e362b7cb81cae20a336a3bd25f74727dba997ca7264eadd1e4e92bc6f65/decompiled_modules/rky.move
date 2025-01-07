module 0xa9e91e362b7cb81cae20a336a3bd25f74727dba997ca7264eadd1e4e92bc6f65::rky {
    struct RKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKY>(arg0, 9, b"RKY", b"Rakzy", b"Here to make everyone rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab4939e1-7bf6-474c-875c-1da1150ebe3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

