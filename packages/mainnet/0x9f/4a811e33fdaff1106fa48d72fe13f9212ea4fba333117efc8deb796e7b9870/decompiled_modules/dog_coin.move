module 0x9f4a811e33fdaff1106fa48d72fe13f9212ea4fba333117efc8deb796e7b9870::dog_coin {
    struct DOG_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_COIN>(arg0, 9, b"DOG", b"Dog Coin", b"Its a dog world out there.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1733207480413618176/E0WAVNK7_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

