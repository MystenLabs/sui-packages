module 0x41cd221335b30f5cb83d377e748b34bc3ddc2197c25b9b359fa7d1a30db447cd::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"Sui Crocodile", b"CROCO is origin friendly crocodile by Matt Furie. If chill - he chill in rich way, if hangs out he is always wasted which makes him literally the best party harder in whole Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/closedai_2d90a5c05e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

