module 0x52fd541f39010829efa7450f3f7ce67c4aa2d26555aa8ff00efcf23ac0845c3::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"SNUT", b"Sui Nut the Squirrel", b"Peanut, the legendary squirrel who stole hearts and sparked outrage, now lives on forever on Sui. A symbol of freedom and a stand against overreach, Peanuts legacy goes decentralized. Long live SNUT! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_94_67fa494a92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

