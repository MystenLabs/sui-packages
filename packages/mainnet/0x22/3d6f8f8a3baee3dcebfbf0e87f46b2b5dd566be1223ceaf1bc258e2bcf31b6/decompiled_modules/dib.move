module 0x223d6f8f8a3baee3dcebfbf0e87f46b2b5dd566be1223ceaf1bc258e2bcf31b6::dib {
    struct DIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIB>(arg0, 6, b"DIB", b"devisbrokeonsui", b"Heres the story of Dev is Broke, a developer who went all-in on a so-called bullish movepump, following the advice of a sketchy Twitter expert. The pump never bounced, and our poor dev, betting everything on a comeback, lost it all... No house, now coding on the street between cardboard boxes, hoping to make a comeback with his token \"Dev is Broke\" and regain a bit of dignity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/49k_T_Cz_W2n_RA_6_D_Hw_EAJJ_4kt_U7_VO_0_d7c89cbe38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

