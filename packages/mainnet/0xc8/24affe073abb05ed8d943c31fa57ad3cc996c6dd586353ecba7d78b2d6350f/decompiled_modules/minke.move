module 0xc824affe073abb05ed8d943c31fa57ad3cc996c6dd586353ecba7d78b2d6350f::minke {
    struct MINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINKE>(arg0, 6, b"MINKE", b"Minke", x"4d696e6b652053776170206f6e20537569206973206120706f77657266756c2074726164652061676772656761746f722064657369676e656420746f2068656c70207573657273207365637572652074686520626573742074726164696e67207261746573206279207365616d6c6573736c7920636f6e6e656374696e6720746f206d756c7469706c6520646563656e7472616c697a65642065786368616e6765732077697468696e20746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736386998750_d5ff94610c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

