module 0xfbc84c21728a9e680d1825fc384c9004c78405b5c79a9bd69b7ec73843271d1::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGO>(arg0, 9, b"SUIGO", b"SUIGO", b"0x7d2e89ec92799d75872a6392f8f6b577141ec97cd925cf5abf0c6a6171fc2ccc::suigo::SUIGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x7d2e89ec92799d75872a6392f8f6b577141ec97cd925cf5abf0c6a6171fc2ccc::suigo::suigo/header.png?size=xl&key=b8216c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGO>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

