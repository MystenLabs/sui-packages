module 0x1124ed4dbf0dbc5b48c872795d4c4c256d433c7f0ae2818b5724826faba9900b::swoosh {
    struct SWOOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOSH>(arg0, 6, b"Swoosh", b"Swoosh on Sui", b"Meet Swoosh - the cutest wizard you'll ever see on this cryptospace! He's here to poof away your problems and make you win in crypto for once.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6079958242999516627_0ab033345e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

