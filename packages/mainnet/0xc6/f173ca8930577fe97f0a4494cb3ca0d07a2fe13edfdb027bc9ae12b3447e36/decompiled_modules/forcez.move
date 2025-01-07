module 0xc6f173ca8930577fe97f0a4494cb3ca0d07a2fe13edfdb027bc9ae12b3447e36::forcez {
    struct FORCEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORCEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORCEZ>(arg0, 6, b"Forcez", b"FORCEATOUS", b"sucezbien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e561699d_a765_4f5a_be0d_33f31b1399b8_c4de056114.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORCEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORCEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

