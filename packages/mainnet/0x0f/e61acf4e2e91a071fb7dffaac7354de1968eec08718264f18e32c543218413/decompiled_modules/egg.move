module 0xfe61acf4e2e91a071fb7dffaac7354de1968eec08718264f18e32c543218413::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"EGG DOG SUI", b"The chosen \"$EGG\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kg_RM_9xj_Y_400x400_88208bf4eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

