module 0x4c058179be18cbadb56c27357e16a5ef18e33ec8cf49cc30cf3b45d8d420750e::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 6, b"SUIL", b"AWKWARD SEAL", b"$SUIL, the Awkward Seal, is a legendary meme that originated on Reddit in 2010.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_CA_3_FF_8_2_310859d721.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

