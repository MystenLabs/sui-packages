module 0xadbfb97d7940630b6079c2140e7f2a6620be1528e7c27ea821441663e04e74d6::sbiao {
    struct SBIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIAO>(arg0, 6, b"SBIAO", b"Sui Biao Qing", b"Join us on a journey where the iconic $BIAO meme meets the dynamic world of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_10_08_02_56_21_578_44dc909571.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

