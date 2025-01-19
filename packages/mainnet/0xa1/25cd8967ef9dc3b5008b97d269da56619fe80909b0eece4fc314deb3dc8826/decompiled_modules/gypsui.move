module 0xa125cd8967ef9dc3b5008b97d269da56619fe80909b0eece4fc314deb3dc8826::gypsui {
    struct GYPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYPSUI>(arg0, 6, b"GYPSUI", b"Gypsui", b"The most gangsta coin on the block. Straight from the ghetto for real hustlers only!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_10_10_18_58_01b5b61895.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

