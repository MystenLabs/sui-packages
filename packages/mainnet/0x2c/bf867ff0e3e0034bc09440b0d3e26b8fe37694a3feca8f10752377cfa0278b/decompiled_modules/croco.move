module 0x2cbf867ff0e3e0034bc09440b0d3e26b8fe37694a3feca8f10752377cfa0278b::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"Croco Sui", b"CROCO is origin friendly crocodile by Matt Furie. If chill - he chill in rich way, if hangs out he is always wasted which makes him literally the best party harder in whole Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/closedai_b32dc0f8dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

