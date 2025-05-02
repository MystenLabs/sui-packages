module 0xd2b9aa593e8bbeea51f6968f39b59545bdddd06eb3911112321e81eadee645d9::babytoilet {
    struct BABYTOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTOILET>(arg0, 6, b"BABYtoilet", b"Baby Toilet", b"Before there was $TOILET, there was $BABYTOILET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babytoilet_5fa368935f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTOILET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTOILET>>(v1);
    }

    // decompiled from Move bytecode v6
}

