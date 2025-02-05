module 0xed0575df1a4aa55dd744115663864d88bf86140c7b6defa44234c0bae173f951::favreau {
    struct FAVREAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAVREAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAVREAU>(arg0, 9, b"FAVREAU", b"Jon Favreau", b"Favreau directed two blockbuster Iron Man movies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcR2ZnJN6E3CKz3P7i95IPqyFQQL4x_qhjRBx0Mf45U6OD6hKloCtcPOzoXMCCVpPf2_vqwLp2oCFKdXKW8ue7fcrNIyrp2_Gw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAVREAU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAVREAU>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAVREAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

