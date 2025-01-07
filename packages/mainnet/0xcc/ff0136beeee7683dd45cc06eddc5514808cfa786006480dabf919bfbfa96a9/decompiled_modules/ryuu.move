module 0xccff0136beeee7683dd45cc06eddc5514808cfa786006480dabf919bfbfa96a9::ryuu {
    struct RYUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYUU>(arg0, 6, b"RYUU", b"SUI RYUU", b"The Ryu is a mythological creature is often depicted living in the ocean is a symbol of power, wisdom, and good luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v9j_N_Of_SP_400x400_93d37611c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

