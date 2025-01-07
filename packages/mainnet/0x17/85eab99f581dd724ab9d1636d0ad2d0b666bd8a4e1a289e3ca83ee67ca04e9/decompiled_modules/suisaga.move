module 0x1785eab99f581dd724ab9d1636d0ad2d0b666bd8a4e1a289e3ca83ee67ca04e9::suisaga {
    struct SUISAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGA>(arg0, 6, b"SUISAGA", b"SUI SAGA", b"Players compete with other players in marble races, communicate, and become winners & get rewarded on $SUISAGA. Integrated with SUI Network developed by Saga.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_37_44_a68c5de7b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

