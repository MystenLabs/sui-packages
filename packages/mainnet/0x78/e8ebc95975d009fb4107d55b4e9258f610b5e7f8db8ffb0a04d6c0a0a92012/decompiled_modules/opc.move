module 0x78e8ebc95975d009fb4107d55b4e9258f610b5e7f8db8ffb0a04d6c0a0a92012::opc {
    struct OPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPC>(arg0, 6, b"OPC", b"OPEN MEME COIN", b"meme coins that belong to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000497694_dea565a33e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

