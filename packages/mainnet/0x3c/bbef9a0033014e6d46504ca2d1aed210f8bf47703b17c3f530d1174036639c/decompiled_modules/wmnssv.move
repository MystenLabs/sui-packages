module 0x3cbbef9a0033014e6d46504ca2d1aed210f8bf47703b17c3f530d1174036639c::wmnssv {
    struct WMNSSV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMNSSV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMNSSV>(arg0, 9, b"WMNSSV", b"hxndn", b"geheh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf2e52aa-c54e-458e-99fb-a2c3c0c09489.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMNSSV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMNSSV>>(v1);
    }

    // decompiled from Move bytecode v6
}

