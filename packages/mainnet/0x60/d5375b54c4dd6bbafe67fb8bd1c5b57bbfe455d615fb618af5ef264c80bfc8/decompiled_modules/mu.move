module 0x60d5375b54c4dd6bbafe67fb8bd1c5b57bbfe455d615fb618af5ef264c80bfc8::mu {
    struct MU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MU>(arg0, 6, b"MU", b"MU token", b"Mu is a playful, curious kitten from Bao Loc, Vietnam. With her silky fur and bright eyes, she charms everyone she meets, bringing joy to her peaceful surroundings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MU_091f93034a.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MU>>(v1);
    }

    // decompiled from Move bytecode v6
}

