module 0x8aa947b6730e728722c733ec47b7ee255fd68bfc351711478b3bcbdc1c963dc0::fourk {
    struct FOURK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURK>(arg0, 6, b"FourK", b"Caught in 4k", b"You just got caught in 4k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GV_Cue_IOWEAA_6_KJA_f3b58d7e3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOURK>>(v1);
    }

    // decompiled from Move bytecode v6
}

