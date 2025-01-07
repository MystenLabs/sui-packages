module 0x3a617c588f7e084793ac6752f72edba77b4ec954a47decc68d6a1212c9aacca8::beersui {
    struct BEERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERSUI>(arg0, 6, b"BEERSUI", b"$BEER SUI", b"$BEER SUI isn't just another coin  it's literally liquid gold. It works as the universal currency of enjoyment, bringing people together regardless of their skin color or social status. Grab some $BEER, invite your friends, and enjoy a great time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_D_D_N_072573afc0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

