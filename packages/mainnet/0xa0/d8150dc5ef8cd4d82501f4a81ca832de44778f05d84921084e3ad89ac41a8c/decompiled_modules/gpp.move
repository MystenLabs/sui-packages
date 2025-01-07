module 0xa0d8150dc5ef8cd4d82501f4a81ca832de44778f05d84921084e3ad89ac41a8c::gpp {
    struct GPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPP>(arg0, 9, b"GPP", b"GREAN", b"FOR BAY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea17ddcc-6317-421f-b3ba-316de02892bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

