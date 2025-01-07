module 0x7a9155e83eec58cfc3577379d2ff6b9b08c554c15d07eee220c693df3444d2d1::crocs {
    struct CROCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCS>(arg0, 6, b"CROCS", b"dogwifcrocs", b"DogWifCrocs Token on SUI is a novel digital asset inspired by the beloved social media trend of dogs wearing Crocs on their head and different parts of their body. This unique token, built on the SUI blockchain, combines the charm of canine companionship with the comfort and style of Crocs footwear. Dogwifcrocs has gained popularity through Pinterest and a tweet by Crocs, creating a vibrant and entertaining digital ecosystem for enthusiasts of both furry friends and iconic footwear.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9fk_Csp_Sq_R_Wq_F_Gcm_V4y_B1ek2gmmm8z_Ns_A_Tk_Zy6_DTR_Spw_A_46cb2fec31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

