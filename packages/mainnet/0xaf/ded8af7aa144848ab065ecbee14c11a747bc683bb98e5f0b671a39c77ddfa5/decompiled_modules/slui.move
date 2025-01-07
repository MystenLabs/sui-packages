module 0xafded8af7aa144848ab065ecbee14c11a747bc683bb98e5f0b671a39c77ddfa5::slui {
    struct SLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUI>(arg0, 6, b"SLUI", b"SLOTH SUI", b"The cryptocurrency that moves slower than a snail on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96554fec2d1162b3d982079279f52c72_91c38b49d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

