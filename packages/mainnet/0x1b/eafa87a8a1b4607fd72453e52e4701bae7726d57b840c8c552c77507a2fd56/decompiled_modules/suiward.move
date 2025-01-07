module 0x1beafa87a8a1b4607fd72453e52e4701bae7726d57b840c8c552c77507a2fd56::suiward {
    struct SUIWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARD>(arg0, 6, b"Suiward", b"Suiward On Sui", b"$Suiward", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wolw_Riw_N_400x400_1_8fcab5bfa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

