module 0x1a664331166cc8bbb59c497564fcf8827d2a9ddda858e3cf8e93139aeb31068d::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 6, b"Dol", b"dolphin", b"To commemorate the hacker attack on Cetus in May 2025, where the united and courageous community demonstrated invincible cohesion to overcome darkness, tokens will be equally distributed to the affected community users, celebrating this great triumph", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748155076337.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

