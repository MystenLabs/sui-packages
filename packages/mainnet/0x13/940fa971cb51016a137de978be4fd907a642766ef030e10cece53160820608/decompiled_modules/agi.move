module 0x13940fa971cb51016a137de978be4fd907a642766ef030e10cece53160820608::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGI>(arg0, 6, b"AGI", b"SUI AGI", b"$SAGI is a Cute meme token On sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sen_w_Y_Zz_400x400_27597505ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

