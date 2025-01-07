module 0xd291a7c15b42f7916ab25ea5782962a6fbbbe3c6442f2344fa143651835b2258::holym {
    struct HOLYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYM>(arg0, 9, b"HOLYM", b"Holymeme", b"A memecoin created solely for the fun of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f38b697-323d-4506-9533-176441853f1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

