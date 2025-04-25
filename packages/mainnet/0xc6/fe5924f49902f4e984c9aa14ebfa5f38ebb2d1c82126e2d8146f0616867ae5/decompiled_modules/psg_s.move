module 0xc6fe5924f49902f4e984c9aa14ebfa5f38ebb2d1c82126e2d8146f0616867ae5::psg_s {
    struct PSG_S has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSG_S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSG_S>(arg0, 9, b"PSG_S", b"psg_sui", b"Paris seint germain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f3d3444b18a6ba7b3ec095eea001e988blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSG_S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSG_S>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

