module 0x6da0cb5e765430f2097b134e086bac56d63a338ff196939f6b33b291f56e7234::ins {
    struct INS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INS>(arg0, 9, b"INS", b"9insights", b"tiktok: @9insights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/963ceb97-b52f-482e-93ca-43475b884e19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INS>>(v1);
    }

    // decompiled from Move bytecode v6
}

