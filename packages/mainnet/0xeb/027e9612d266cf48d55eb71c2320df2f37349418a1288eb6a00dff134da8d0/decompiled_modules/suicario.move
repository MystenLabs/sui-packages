module 0xeb027e9612d266cf48d55eb71c2320df2f37349418a1288eb6a00dff134da8d0::suicario {
    struct SUICARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICARIO>(arg0, 6, b"SUICARIO", b"Suicario On Sui", b"The first Pokemon hunting game on @SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidi5oz3udh7rkpngod2drw7cmg4uvnknunvrt6c6a5dusx244wy7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

