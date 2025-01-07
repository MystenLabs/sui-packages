module 0x4acafed7503ed08ba132a8d8514322b5fa986fac3474b839045cbe68f505eb58::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOG>(arg0, 6, b"BIRDDOG", b"Bird Dog On Sui", b"BirdDog is the 5th member to join Pepes gang of roommates, otherwise known as the Boys Club created by Matt Furie. According to Furie, he created Bird Dog as a way to introduce a character into the series that was based off... himself! Bird dog was supposed to be Matt Furie in his younger days.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BINGDOG_0d06d5821f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

