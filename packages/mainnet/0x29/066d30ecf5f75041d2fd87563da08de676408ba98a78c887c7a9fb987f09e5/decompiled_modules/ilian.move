module 0x29066d30ecf5f75041d2fd87563da08de676408ba98a78c887c7a9fb987f09e5::ilian {
    struct ILIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILIAN>(arg0, 9, b"ILIAN", b"IM LIAN", b"LIAN MEME IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2a8de14-b221-419b-b867-7c68dba0ba1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

