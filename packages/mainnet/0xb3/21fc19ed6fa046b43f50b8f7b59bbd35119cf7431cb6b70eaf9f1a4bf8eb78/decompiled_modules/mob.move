module 0xb321fc19ed6fa046b43f50b8f7b59bbd35119cf7431cb6b70eaf9f1a4bf8eb78::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"MobSuiOTC", b"The Greatest Whale of all time is coming to the Ocean of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000641_cb32726160.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

