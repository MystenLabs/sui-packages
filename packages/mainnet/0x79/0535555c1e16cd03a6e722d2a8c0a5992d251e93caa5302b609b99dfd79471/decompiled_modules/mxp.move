module 0x790535555c1e16cd03a6e722d2a8c0a5992d251e93caa5302b609b99dfd79471::mxp {
    struct MXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXP>(arg0, 9, b"MXP", b"MaxPro", b"Maximum Professional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e334e396-767f-4551-bf3b-277316cec959.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

