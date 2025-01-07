module 0x6106c2b1c0f75b6fe3c761de255e35f8dc296f575b46417195f37634852528f7::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"CORN", b"CORN on SUI", b"The first and only organic tokenized unicorn. Each $CORN token contains one nanogram of unicorn DNA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Iz_V_Tb_C8_400x400_df0be217f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

