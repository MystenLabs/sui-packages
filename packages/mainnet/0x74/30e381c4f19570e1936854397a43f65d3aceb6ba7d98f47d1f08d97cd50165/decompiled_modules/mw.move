module 0x7430e381c4f19570e1936854397a43f65d3aceb6ba7d98f47d1f08d97cd50165::mw {
    struct MW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MW>(arg0, 9, b"MW", b"MeWe", x"4d6577652073e1bbb1206be1babf742068e1bba370206769e1bbaf61204d656d652076c3a02057657765", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba1468fd-4863-4778-81ff-e7195a314c6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MW>>(v1);
    }

    // decompiled from Move bytecode v6
}

