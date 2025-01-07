module 0xf2a35d2f077c93b97132b3789a632127367a54b6da966c5eeb8dcf9f2abae3aa::wick {
    struct WICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICK>(arg0, 6, b"WICK", b"Wick", x"4d79206e616d65206973205769636b2e200a0a4920616d206120706f6f7220537472656574204361742e200a446973636f76657265642062792046616d6f7573204b6f6c732e202843727970746f204d65737369616829200a0a5468616e6b20796f7520666f722066656564696e67206d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000082234_3e66a5db3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

