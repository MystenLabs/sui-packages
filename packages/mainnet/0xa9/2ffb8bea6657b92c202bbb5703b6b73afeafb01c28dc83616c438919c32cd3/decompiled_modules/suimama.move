module 0xa92ffb8bea6657b92c202bbb5703b6b73afeafb01c28dc83616c438919c32cd3::suimama {
    struct SUIMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAMA>(arg0, 6, b"SUIMAMA", b"SuiMama", b"the punniest meme coin on sui. parody of popular childrens book and here to provide artistic commentary missing in the crypto space. The fight against scammers remains as we call out projects with the rug touch ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/knockout_c93c8a28b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

