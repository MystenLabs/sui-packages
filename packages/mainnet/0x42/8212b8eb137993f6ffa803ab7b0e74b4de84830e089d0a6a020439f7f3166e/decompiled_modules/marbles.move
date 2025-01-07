module 0x428212b8eb137993f6ffa803ab7b0e74b4de84830e089d0a6a020439f7f3166e::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"MARBLE SAGA", b"Players compete with other players in marble races, communicate, and become winners & get rewarded on $MARBLES. Integrated with SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_37_44_94b92cd118.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

