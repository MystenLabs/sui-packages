module 0x5322912dbc5e922c2a11f42c5025a318d9e5da89296f36a937dc78fe4014d6d2::wos {
    struct WOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOS>(arg0, 6, b"WOS", b"Waterboarded On SUI", b"\"I know Nothing! GRGLGRGLGLRGL\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waterboardcat_4216456f0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

