module 0xa9d8bcf21aa2c5eb1c092fd1ec30808aac20877b6658190069e098c8abd8d673::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 6, b"CHEEKS", b"CHEEKS ON SUI", b"HELP CHEEKS TO FIND THE  PEACE OF THE NATURE....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BIRD_0ecadaabf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

