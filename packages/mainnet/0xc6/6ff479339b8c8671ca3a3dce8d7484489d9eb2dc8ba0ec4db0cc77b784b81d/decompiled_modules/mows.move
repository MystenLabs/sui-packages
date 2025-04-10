module 0xc66ff479339b8c8671ca3a3dce8d7484489d9eb2dc8ba0ec4db0cc77b784b81d::mows {
    struct MOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWS>(arg0, 6, b"MOWS", b"Meme Of Wall Street", b"SUI meme coin inspired from the most iconic movie about money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_Leonardo_Di_Caprio_in_a_sleek_black_suit_laugh_0_887d3c68ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

