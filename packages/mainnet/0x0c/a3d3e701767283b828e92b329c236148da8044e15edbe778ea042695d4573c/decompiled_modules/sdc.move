module 0xca3d3e701767283b828e92b329c236148da8044e15edbe778ea042695d4573c::sdc {
    struct SDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDC>(arg0, 6, b"SDC", b"SUI DAILY CALLS", b"BEST CALL CHANNEL ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_img2_04cf603de1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

