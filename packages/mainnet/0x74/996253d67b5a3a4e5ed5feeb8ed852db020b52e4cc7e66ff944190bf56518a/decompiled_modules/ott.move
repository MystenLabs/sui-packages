module 0x74996253d67b5a3a4e5ed5feeb8ed852db020b52e4cc7e66ff944190bf56518a::ott {
    struct OTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTT>(arg0, 9, b"OTT", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/365d0f66-2999-4242-9933-a9b16b486a3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

