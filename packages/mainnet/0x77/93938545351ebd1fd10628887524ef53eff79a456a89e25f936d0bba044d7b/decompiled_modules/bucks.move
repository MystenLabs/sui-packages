module 0x7793938545351ebd1fd10628887524ef53eff79a456a89e25f936d0bba044d7b::bucks {
    struct BUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKS>(arg0, 6, b"BUCKS", b"BluebucksOnSui", b"Sui secret to succes is blue And pinchy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_180341_128d806d10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

