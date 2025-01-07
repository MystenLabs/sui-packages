module 0xc71b4a7d668be5e3916474bcc343a118e0ec7359d190c5517133590113fe8e2d::scrab {
    struct SCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAB>(arg0, 9, b"SCrab", b"SuiCrab", b"Come and catch me, if you dare of course", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a97c46dd9829c75ad392d547bd4020d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCRAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

