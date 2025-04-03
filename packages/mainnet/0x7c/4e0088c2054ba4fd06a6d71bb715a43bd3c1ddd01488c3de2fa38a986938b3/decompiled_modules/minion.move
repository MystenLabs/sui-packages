module 0x7c4e0088c2054ba4fd06a6d71bb715a43bd3c1ddd01488c3de2fa38a986938b3::minion {
    struct MINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINION>(arg0, 6, b"Minion", b"MinionToken", b"Welcome to the next generation of coin memes, the most mischievous and adorable minions ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/486975867_555530600886241_1367151188563900502_n_5c075934d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINION>>(v1);
    }

    // decompiled from Move bytecode v6
}

