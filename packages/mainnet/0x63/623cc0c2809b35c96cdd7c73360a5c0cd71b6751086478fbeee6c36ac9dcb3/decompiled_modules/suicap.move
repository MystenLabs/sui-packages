module 0x63623cc0c2809b35c96cdd7c73360a5c0cd71b6751086478fbeee6c36ac9dcb3::suicap {
    struct SUICAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAP>(arg0, 6, b"SUICAP", b"SuiCup On Sui", b"Fill your cup with sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001737_878ec82e07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

