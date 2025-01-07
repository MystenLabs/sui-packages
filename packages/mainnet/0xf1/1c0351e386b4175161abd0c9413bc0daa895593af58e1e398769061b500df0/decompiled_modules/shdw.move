module 0xf11c0351e386b4175161abd0c9413bc0daa895593af58e1e398769061b500df0::shdw {
    struct SHDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHDW>(arg0, 6, b"Shdw", b"Shadow", b"coming from the shadows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x630bb_bb8fe26395.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHDW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

