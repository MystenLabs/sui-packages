module 0x192e553a22bd65c507468e1cec2e7bfac9d21d11a88f81098d7354e7477b9026::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 6, b"DOGGY", b"Doggy", b"$DOGGY is a silly dog for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073720_23c6058045.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

