module 0xa22d65e61fb3c183a51533f06de21c5efb433bb67bb6fde84d9330521802462e::mcf {
    struct MCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCF>(arg0, 9, b"MCF", b"Mischief", b"Meet Mischief: The orange cat with a knack for causing chaos and stealing hearts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/50562a732c2af7d0460001d609d317c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

