module 0x65e7754152815b65e6cc6e3d8dc0b0f02c67595038f0b3d62acc0d9431c6c0da::fwn {
    struct FWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FWN>(arg0, 6, b"FWN", b"FairWin by SuiAI", b"FairWin represents the opportunity to win your rightful rewards powered by AI prediction, ensuring transparency and trust throughout the process.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/fairwin_logo_011cc66454.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FWN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

