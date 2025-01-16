module 0xa0aa3c0bae0d93858f2cc40cb42ae5a9cabf79cd03a37720bbd9559188f10a4f::pose {
    struct POSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POSE>(arg0, 6, b"POSE", b"POSUIDON.AI by SuiAI", b"Majestic guardian of the SUI ocean. Protecting the community from scams and rug pulls.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gh_TW_Ho_Hb_QA_Arfz_N_279e6f2733.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POSE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

