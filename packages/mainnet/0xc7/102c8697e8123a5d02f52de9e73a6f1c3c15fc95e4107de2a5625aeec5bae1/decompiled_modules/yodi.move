module 0xc7102c8697e8123a5d02f52de9e73a6f1c3c15fc95e4107de2a5625aeec5bae1::yodi {
    struct YODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODI>(arg0, 6, b"YODI", b"Yodi the christmas elf", x"596f646920746865206e657874205945544920746f2074616b65206e6f74206f6e6c792053756920627574207468652077686f6c652063727970746f206d61726b65742062792073746f726d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_13_84b1b34ac0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

