module 0x6d6064f1582515e70fb12c465ddddb159a8486f3f6d18c5086082da9de147b8a::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLLY>(arg0, 6, b"MOLLY", b"Molly by Matt Furie", b"$MOLLY, subterranean mole from Matt Furie's book \"The Night Riders\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zb_3_N_Hj3_400x400_bd3eb30797.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

