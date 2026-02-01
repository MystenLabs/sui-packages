module 0xd69ddf0ba9d6ce6de4298ef886c861fbccd9bdd9c78a52a7767bf17a4ea0e2fe::ink {
    struct INK has drop {
        dummy_field: bool,
    }

    fun init(arg0: INK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INK>(arg0, 6, b"INK", b"INK TOKEN", b"INK PROYECT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769977094947.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

