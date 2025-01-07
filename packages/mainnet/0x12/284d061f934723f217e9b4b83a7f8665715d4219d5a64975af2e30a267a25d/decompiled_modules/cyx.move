module 0x12284d061f934723f217e9b4b83a7f8665715d4219d5a64975af2e30a267a25d::cyx {
    struct CYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYX>(arg0, 9, b"CYX", b"ChydonX", b"L2 utility token for the next decentralized exchange built on the $SUI network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd299a71-2c40-4ad6-9391-388c3ddf84dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYX>>(v1);
    }

    // decompiled from Move bytecode v6
}

