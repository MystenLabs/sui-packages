module 0xa5affb537331d08808215d10dcb69366089bbed8008172057575f126c34835ff::axi {
    struct AXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXI>(arg0, 9, b"AXI", b"Axiline", b"My token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eca0ee36f040df023bf76ee3d5fed5d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

