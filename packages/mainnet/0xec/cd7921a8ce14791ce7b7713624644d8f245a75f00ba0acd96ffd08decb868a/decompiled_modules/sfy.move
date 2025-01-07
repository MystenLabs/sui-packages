module 0xeccd7921a8ce14791ce7b7713624644d8f245a75f00ba0acd96ffd08decb868a::sfy {
    struct SFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFY>(arg0, 6, b"SFY", b"SUI FLUFFY", b"FLUFFY is FOR THE PEOPLE my idea of Crypto isnt the PVP its we the People Vs those who have turned Humanity in DEBT SLAVES LETS all WIN as one $FLUFFY is the ANSWER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0000_af3a0c7c8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

