module 0x4c359bad5ca38eaaff049e5f55c490b53a73fd4c3586969cb16066c75dfbd124::rickrsui {
    struct RICKRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKRSUI>(arg0, 6, b"RICKRSUI", b"RICKSUI", b"$RICKSUI is here to never give you up! Now, $RICKSUI is rolling onto SUI and will never let you down.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_31_f520c494e8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

