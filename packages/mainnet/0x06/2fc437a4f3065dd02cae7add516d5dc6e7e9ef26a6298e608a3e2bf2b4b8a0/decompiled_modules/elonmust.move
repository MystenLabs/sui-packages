module 0x62fc437a4f3065dd02cae7add516d5dc6e7e9ef26a6298e608a3e2bf2b4b8a0::elonmust {
    struct ELONMUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUST>(arg0, 9, b"ELONMUST", b"X", b"Buy Premium Now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dd742d2-5433-4b6a-a7f3-cae60900224b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

