module 0xcb32842d6625453413619ef58c34ceefe2fadba565fb8560fcbcbd2358ec5176::agpt {
    struct AGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGPT>(arg0, 6, b"AGPT", b"AgentGPT", b"ioneering AI, we bridge the gap between brain-computer interface implants & human consciousness. Get ready for the next step in human evolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3w_Ni_DF_3_400x400_db7c7fc89e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

