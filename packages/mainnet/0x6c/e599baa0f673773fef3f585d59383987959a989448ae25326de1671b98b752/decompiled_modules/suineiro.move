module 0x6ce599baa0f673773fef3f585d59383987959a989448ae25326de1671b98b752::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 6, b"SuiNeiro", b"Neiro", b"$NEIRO on SUI is the heir apparent to dodge, the new Shiba Inu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u0rx_Azc1_400x400_61941f4239.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

