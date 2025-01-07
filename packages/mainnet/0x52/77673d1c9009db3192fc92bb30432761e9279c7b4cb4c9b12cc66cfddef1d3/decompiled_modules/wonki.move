module 0x5277673d1c9009db3192fc92bb30432761e9279c7b4cb4c9b12cc66cfddef1d3::wonki {
    struct WONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKI>(arg0, 6, b"WONKI", b"Wonki Coin", x"63727970746f206372617a652c206c6173657220626c617a65210a7765277265206865726520746f2074616b65206f76657220737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wonki_Coin_Logo_d4b89cb3bd_8203301d77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

