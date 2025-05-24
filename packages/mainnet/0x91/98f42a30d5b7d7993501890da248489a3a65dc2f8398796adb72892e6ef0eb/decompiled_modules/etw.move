module 0x9198f42a30d5b7d7993501890da248489a3a65dc2f8398796adb72892e6ef0eb::etw {
    struct ETW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETW>(arg0, 6, b"ETW", b"Eat The Whale", b"$ETW  A project born from the undercurrent. For the overlooked. For the many.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073462_181f4aaa0c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETW>>(v1);
    }

    // decompiled from Move bytecode v6
}

