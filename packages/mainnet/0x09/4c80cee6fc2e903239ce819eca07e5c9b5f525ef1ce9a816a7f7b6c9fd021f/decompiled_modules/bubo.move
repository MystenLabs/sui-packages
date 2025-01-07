module 0x94c80cee6fc2e903239ce819eca07e5c9b5f525ef1ce9a816a7f7b6c9fd021f::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"Buboonsui", b"The most adorable Orca on $SUI, launching very soon on MovePump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipo_324a8a5636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

