module 0x4748368b1466adc2e5dd90426264aed44c9dd759b2908c4d6855ebb0962081::mack {
    struct MACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MACK>(arg0, 6, b"MACK", b"Mack the Meowing Cat on SUI by SuiAI", b"The noisiest cat in the world. Meows when frustrated. Meows when contented. Meows when hungry. Meows non-stop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/c_Bc_MY_Acx_400x400_2218e5d6a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MACK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

