module 0xcf814593d63cfa2909c8923411c83bbc99281ca8b83b24d91894d712c9226a57::americapac {
    struct AMERICAPAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERICAPAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERICAPAC>(arg0, 6, b"AmericaPAC", b"American", b"America PAC was created to support these key values & leaders who fight for them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tif_VL_0k_N_09dbfe3557.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERICAPAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMERICAPAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

