module 0x200c3264d593c7336490370cfd1a02e1c892a02839e567d9c3f56ba5dcbb6101::picoin {
    struct PICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICOIN>(arg0, 9, b"PICOIN", b"Pi Network", b"Official pi network coin by nicolas kokkalis team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa1e9dea-f0a8-4e3d-8839-e17972846a34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

