module 0xe8f21ad0de144d05ff13649d914937d34ce51d28f6f0ee6d440036f2038cc8ea::kura {
    struct KURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURA>(arg0, 6, b"KURA", b"SuiKura", b"Kura in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_9ed5125d02.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

