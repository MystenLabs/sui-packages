module 0xee98d16dfcd18170b5a61ee8bd1ec02501281752f601d098d5ee0d4b9d38e724::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 6, b"BLOW", b"Blow the Blowfish", b"Blow the Blowfish has come to take over the waters of Sui. Hold Tight, Prepare to Inflate!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1_ae650e056e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

