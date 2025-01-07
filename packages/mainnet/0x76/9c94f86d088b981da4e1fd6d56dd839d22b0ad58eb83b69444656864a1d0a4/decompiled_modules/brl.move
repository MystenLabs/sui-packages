module 0x769c94f86d088b981da4e1fd6d56dd839d22b0ad58eb83b69444656864a1d0a4::brl {
    struct BRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRL>(arg0, 6, b"BRL", b"Brazil", b"Ordem e Progresso", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734791533677.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

