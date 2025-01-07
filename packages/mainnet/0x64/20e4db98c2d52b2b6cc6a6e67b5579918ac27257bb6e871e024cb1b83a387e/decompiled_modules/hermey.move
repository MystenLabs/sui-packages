module 0x6420e4db98c2d52b2b6cc6a6e67b5579918ac27257bb6e871e024cb1b83a387e::hermey {
    struct HERMEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERMEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERMEY>(arg0, 6, b"Hermey", b"Hermey The Elf", b"Hermey the Misfit Elf is one of Santa Claus' elves but Unlike the other elves, he does not enjoy making toys, instead pursuing a career in dentistry; he is teased by them because of this, much like how Rudolph is teased for his glowing red nose. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734203866958.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERMEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERMEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

