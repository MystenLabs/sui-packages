module 0x62573fde27381c377fcdb18857fefb985315197700eb5f4e6074e3d891d00704::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Scuba Cat", x"446976696e6720696e746f204f6365616e73206f6620437574656e6573732c746865206d6f73742061646f7261626c6520636174206f6e200a537569204e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCAT_fb0128eaba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

