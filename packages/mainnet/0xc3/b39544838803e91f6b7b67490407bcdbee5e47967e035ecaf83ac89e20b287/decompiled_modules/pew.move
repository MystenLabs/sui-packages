module 0xc3b39544838803e91f6b7b67490407bcdbee5e47967e035ecaf83ac89e20b287::pew {
    struct PEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEW>(arg0, 9, b"PEW", b"PEW-PEW", b"JUST FOR FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/edb077e40580c013aa368103b4d83695blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

