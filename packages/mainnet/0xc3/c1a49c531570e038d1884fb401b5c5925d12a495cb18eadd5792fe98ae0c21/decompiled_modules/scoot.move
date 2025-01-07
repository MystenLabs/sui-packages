module 0xc3c1a49c531570e038d1884fb401b5c5925d12a495cb18eadd5792fe98ae0c21::scoot {
    struct SCOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOOT>(arg0, 6, b"SCOOT", b"Scoot On Sui", b"The most woke empty house family friendly no1 orange juice stand in the area billionaire dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Avatar_eb8a58ca5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

