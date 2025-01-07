module 0xa74a369a8c0abec311fc77ed9e350615fbef429727e5fd04caee65b718903945::posuidon {
    struct POSUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUIDON>(arg0, 6, b"Posuidon", b"Posuidon on Sui", b"Meet $POSUDION, the mighty ruler of the Sui waters!  With his trident in hand, he commands the waves and unleashes the true power of the ocean on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poseidon_0777e73e12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

