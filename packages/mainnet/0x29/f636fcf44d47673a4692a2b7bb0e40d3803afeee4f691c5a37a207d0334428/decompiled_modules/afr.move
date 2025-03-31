module 0x29f636fcf44d47673a4692a2b7bb0e40d3803afeee4f691c5a37a207d0334428::afr {
    struct AFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFR>(arg0, 9, b"AFR", b"AFRI", b"To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5417867af0b4f9db8efc243db8c03ac3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

