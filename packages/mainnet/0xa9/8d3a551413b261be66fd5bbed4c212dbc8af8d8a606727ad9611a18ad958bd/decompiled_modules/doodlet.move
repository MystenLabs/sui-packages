module 0xa98d3a551413b261be66fd5bbed4c212dbc8af8d8a606727ad9611a18ad958bd::doodlet {
    struct DOODLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLET>(arg0, 6, b"DOODLET", b"Doodle Trump", b"Meet our unique character who jumps to victory in the style of Donald Trump, with his signature hairstyle and suit! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ecffda27de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

