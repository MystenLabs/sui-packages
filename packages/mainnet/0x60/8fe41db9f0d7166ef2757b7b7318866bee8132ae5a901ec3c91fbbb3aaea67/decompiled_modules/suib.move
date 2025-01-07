module 0x608fe41db9f0d7166ef2757b7b7318866bee8132ae5a901ec3c91fbbb3aaea67::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"SUIB", b"SuibaInu", b"Doge is mooning SuibaInu will follow but this time under the water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shib_shiba_inu_ai_dollar_give_offer_web_jpg_Photoroom_Photoroom_2_9b871277cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

