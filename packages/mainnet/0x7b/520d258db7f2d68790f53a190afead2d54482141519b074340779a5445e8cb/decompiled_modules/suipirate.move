module 0x7b520d258db7f2d68790f53a190afead2d54482141519b074340779a5445e8cb::suipirate {
    struct SUIPIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIRATE>(arg0, 6, b"SUIPIRATE", b"SUI Starfish Pirate", b"Welcome aboard the SUI Starfish Pirate adventure Lets discover treasures and create legends together.  $SUIPIRATE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Messenger_creation_978_C02_BE_7_ED_4_42_A8_B39_B_B6_F3_A477_D769_76d440e47f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

