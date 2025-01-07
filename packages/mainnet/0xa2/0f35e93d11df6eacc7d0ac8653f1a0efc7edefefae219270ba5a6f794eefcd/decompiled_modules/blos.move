module 0xa20f35e93d11df6eacc7d0ac8653f1a0efc7edefefae219270ba5a6f794eefcd::blos {
    struct BLOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOS>(arg0, 9, b"BLOS", b"BLACK ROSE", b"The black rose blooms only once a year. Touch the magic, don't be afraid of the thorns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c188de59-82dc-47b0-a46d-68b0e44161b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

