module 0x3a372890337844b69f4a091ba126dc5191adc6755245dc267da29f6fe0f746c6::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"SuiDINO", b"DINO, THE MOST PREDITORY ANIMAL IN THE SUI NETWORK, IS NOW HERE WITH BOTH HIS PREDICTION AND CUTENESS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198041_900055eeed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

