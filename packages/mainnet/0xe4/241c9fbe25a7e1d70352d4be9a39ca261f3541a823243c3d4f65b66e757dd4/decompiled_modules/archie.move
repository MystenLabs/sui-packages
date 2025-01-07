module 0xe4241c9fbe25a7e1d70352d4be9a39ca261f3541a823243c3d4f65b66e757dd4::archie {
    struct ARCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCHIE>(arg0, 6, b"ARCHIE", b"ARCHIE DOG", b"ARCHIE DOG ON SUI. SOCIAL EXPERIMENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/happy_archie_dog_v0_xw5ct9mlh0aa1_1859176050_2ce70cd297.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

