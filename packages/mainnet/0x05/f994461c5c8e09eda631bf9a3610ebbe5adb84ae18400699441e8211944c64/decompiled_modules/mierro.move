module 0x5f994461c5c8e09eda631bf9a3610ebbe5adb84ae18400699441e8211944c64::mierro {
    struct MIERRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIERRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIERRO>(arg0, 6, b"MIERRO", b"Mierro on sui", b"$Mierro een gospel of memes while unearthing the juiciest opportunities in the market with Ai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055685_bca064cd61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIERRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIERRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

