module 0x4851f1f636d971c88745686b00e7e4770e4527ed9aff67a7af12e429f93b3ed6::ottier {
    struct OTTIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTIER>(arg0, 6, b"OTTIER", b"OTTIER ON SUI", b"$OTTIER is a cute, speedy, Sui-themed cyber otter darting through the Sui waters. With its sleek moves and playful spirit, $OTTIER is here to bring fun and momentum to the Sui network. Dive in and swim alongside the swiftest otter around!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OTTIER_813a8d54bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

