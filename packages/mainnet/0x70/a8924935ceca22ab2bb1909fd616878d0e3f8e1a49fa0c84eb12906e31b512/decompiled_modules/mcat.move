module 0x70a8924935ceca22ab2bb1909fd616878d0e3f8e1a49fa0c84eb12906e31b512::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 6, b"MCAT", b"Moon Cat", b"Moon Cat, the next big memecoin to take the Sui network by Tsunami Wave! From the same developer who brought you Scuba Cat, which exploded with a massive x26 on launch, Moon Cat is primed for another stellar rise. With Moon Cat, were not just reaching for the moon; were aiming to redefine memecoin mania.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moon_Cat_1_4ee8bd7c8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

