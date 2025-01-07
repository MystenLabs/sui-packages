module 0x143a8b4acdf04943eae5debeec991572d16f5c5d4461e76d54a773823418534::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 6, b"DOGEFATHER", b"dogefather", b"DogeFather", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9548_ce00a4c9bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

