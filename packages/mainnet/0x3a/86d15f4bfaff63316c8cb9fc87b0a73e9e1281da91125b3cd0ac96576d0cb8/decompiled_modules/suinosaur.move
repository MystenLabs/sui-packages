module 0x3a86d15f4bfaff63316c8cb9fc87b0a73e9e1281da91125b3cd0ac96576d0cb8::suinosaur {
    struct SUINOSAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOSAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOSAUR>(arg0, 6, b"SUINOSAUR", b"Sui Dinosaur", b"A blast from the past, $SUINOSAUR roars back into the Sui Network. Big, fierce, and ancient this dinos got a footprint thats impossible to miss. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_t_rexdinasaurconcept_artart_5b07ff66_f612_4ffc_9849_830d33146d4f_10da3ce075.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOSAUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOSAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

