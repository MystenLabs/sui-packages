module 0xc1504eac88c01b1160227ba7d21eb6bba8802f2ac19174e0438340ec145ebafb::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"KOBAN", b"KOBAN", b"KOBAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploads-ssl.webflow.com/6274e966bc04c37c20e1f0f8/6494605e9ed9b559f85e0df3_coin_3.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOBAN>(&mut v2, 2500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

