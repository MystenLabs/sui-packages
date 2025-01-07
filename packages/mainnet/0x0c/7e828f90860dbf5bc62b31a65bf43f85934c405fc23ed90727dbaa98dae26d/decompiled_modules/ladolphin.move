module 0xc7e828f90860dbf5bc62b31a65bf43f85934c405fc23ed90727dbaa98dae26d::ladolphin {
    struct LADOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADOLPHIN>(arg0, 6, b"LaDolphin", b"Lady Dolphin", b"meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a0ea289_dde1_4aaf_9b4a_6e35b4332282_62b111728c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

