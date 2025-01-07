module 0x904646999850ff696604208efb8b701ac5c216241bab3a9afdb9a90283f0f21e::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 6, b"NPC", b"NPC SUI", b"Are u NPC ? just meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951809190.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

