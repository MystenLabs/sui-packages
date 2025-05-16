module 0x761d65b02e457d3752f5460caa4f9f7abdd389295e02029d7dd4165546dd7d8e::bo {
    struct BO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BO>(arg0, 9, b"BO", b"BroToken", b"best of", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6793fb08ad48cd29b7cd3b83b18d64ccblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

