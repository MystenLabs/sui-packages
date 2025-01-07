module 0x2b31d8510b619c45e896d8743f4611b79e63a0bcff5a2c78e9dbc744977c4e59::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 6, b"SUICIDE", b"$uicideboy$", b"Suicideboys (stylized as $UICIDEBOY$) is an American hip hop duo from New Orleans, Louisiana. Formed in 2014 by cousins Scrim (stylized as $crim) and Ruby da Cherry, the duo initially rose to popularity on SoundCloud for their abrasive, self-produced beats, as well as their harsh lyrical content and themes prominently featuring substance abuse and suicidal ideation. They own and operate their own label, G*59 Records, under which all of their music is distributed by The Orchard.[3][4]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_OV_3c9zf_Q_Ug29_M9_LF_2_C_Kk_Fg_t500x500_29a9c090de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

