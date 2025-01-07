module 0xe60a2fe7e867d40fc50866b893ebe65b8422f3afb04c63d0cc995ec8cc051255::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"POSUIDON", b"POSEIDON of the SUI SEAS!", b"$POSUIDON is a powerful token on Sui. It commands the seas, wields thunderbolts, and strikes with the force of a trident. Just like Poseidon rules the oceans, $POSUIDON gives its holders the power to dominate the Sui seas with strength and precision!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POSUIDON_3000e541a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

