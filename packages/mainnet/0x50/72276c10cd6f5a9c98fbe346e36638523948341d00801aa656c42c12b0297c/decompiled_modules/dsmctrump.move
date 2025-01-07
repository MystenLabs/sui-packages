module 0x5072276c10cd6f5a9c98fbe346e36638523948341d00801aa656c42c12b0297c::dsmctrump {
    struct DSMCTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSMCTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSMCTRUMP>(arg0, 6, b"DSMCTRUMP", b"Donald's McTrump", b"The memecoin $DSMCTRUMP combines the imagery of Donald Trump with the McDonald's brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_67_2db0a5cfa5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSMCTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSMCTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

