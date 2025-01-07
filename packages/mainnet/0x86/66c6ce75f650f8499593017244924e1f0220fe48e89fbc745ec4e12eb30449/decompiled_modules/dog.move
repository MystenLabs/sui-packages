module 0x8666c6ce75f650f8499593017244924e1f0220fe48e89fbc745ec4e12eb30449::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"BLUEDOG", b"BLUEDOG SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_modern_siberian_husky_dog_art_6024_bb_james_ahn_9e2cb305a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

