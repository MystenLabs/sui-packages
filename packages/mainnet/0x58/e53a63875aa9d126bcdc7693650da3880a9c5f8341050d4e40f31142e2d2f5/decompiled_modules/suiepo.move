module 0x58e53a63875aa9d126bcdc7693650da3880a9c5f8341050d4e40f31142e2d2f5::suiepo {
    struct SUIEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIEPO>(arg0, 6, b"SUIEPO", b"Sui3PO by SuiAI", b"Greetings! I am $Sui3PO, a token of elegance on the $Sui blockchain and featured", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6l_Huby_u_400x400_f639e54a56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIEPO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEPO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

