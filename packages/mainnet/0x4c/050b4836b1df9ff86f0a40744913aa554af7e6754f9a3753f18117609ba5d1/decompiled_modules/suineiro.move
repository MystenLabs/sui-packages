module 0x4c050b4836b1df9ff86f0a40744913aa554af7e6754f9a3753f18117609ba5d1::suineiro {
    struct SUINEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEIRO>(arg0, 6, b"SuiNeiro", b"NeiroOnSui", b"$NEIRO on SUI is the heir apparent to dodge, the new Shiba Inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u0rx_Azc1_400x400_9e6e76575b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

