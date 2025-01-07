module 0xe4dcd04aba6482bc6bcc05d313c85ddece4da660e00734e5b6a708f761f61d75::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 6, b"DEX", b"SUIDEX", b"Bring dexscreen to sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x630wa_071a3b915d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

