module 0xa6b97d65049a1959887b4a81c4b234209b261bb975e45bc8721f1798e04c4457::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Poseidon Agent", b"Poseidon is an advanced AI agent built to provide real-time Image analysis of the $SUI network. It specializes in design, animation. Second Citizen of $ATL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_27_18_07_07_5c7b88b37a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

