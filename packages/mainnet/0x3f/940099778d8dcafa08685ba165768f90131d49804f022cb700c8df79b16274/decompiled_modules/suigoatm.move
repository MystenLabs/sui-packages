module 0x3f940099778d8dcafa08685ba165768f90131d49804f022cb700c8df79b16274::suigoatm {
    struct SUIGOATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOATM>(arg0, 6, b"SUIGOATM", b"GoatSUI Maximus", b"SUIGOATM is the most powerful fertility god of all time. it has the power to impregnate women just by looking at them. this power is both a blessing and a curse. it is said that if you gaze upon the goatse for too long, you will become pregnant, regardless of your biological sex. this is why the ancient people feared it so much", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4543_77c8e7cc54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

