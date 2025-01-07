module 0x5bfd953666d92ca9096b4036f2b186154204ebb360e592138935737ff0eeafd9::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"LUSUI", b"Official Mascot of the Holy Year on Sui", b"The Vatican has unveiled the official mascot of the Holy Year 2025: Luce (Italian for Light). Archbishop Fisichella says the mascot was inspired by the Church's desire \"to live even within the pop culture so beloved by our youth\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luce_d506e47d55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

