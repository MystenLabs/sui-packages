module 0x5e2f48973786a98a9f042a5b7f51d0719671919c6aa893d2391c70a532443792::trfsui {
    struct TRFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRFSUI>(arg0, 6, b"TRFsui", b"TRUFFY", b"A unique meme token inspired by the elegance and charm of truffle hunting, brought to life on the Sui bloAckchain. With its playful yet sophisticated pig mascot, TRUFF combines humor with a sense of rarity and exclusivity, just like the truffles it represents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1734442840738_736441da71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

