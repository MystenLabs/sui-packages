module 0x45193ba66e55b75ff07036a3d7db59b969f100fecce0e8d0f0e308ff6233e3e1::bdoge {
    struct BDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOGE>(arg0, 6, b"BDOGE", b"BDOGE on SUI", x"4a757374206b696c6c696e672062656172732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rj_H_Qv_B8y_400x400_db23bc3058.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

