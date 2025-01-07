module 0xb37305543de8b37a9ec6a6c2ad56f63c1cae4cc783921c1fcc9b664794f4ca6::roses {
    struct ROSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSES>(arg0, 6, b"ROSES", b"Rose on Sui", b"Dexscreener Paid.Check here : https://www.rosecoinonsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_3_c37cf0d423.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

