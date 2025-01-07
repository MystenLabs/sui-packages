module 0x86c36b58d4c20268def4af164589d16e2f0c50f553eba66c4cce7af31d9a92c3::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi Blob", b"The fluffly, squishy and hungry blob living his best life in the Sui universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WR_7_Hev86_400x400_be0465494f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

