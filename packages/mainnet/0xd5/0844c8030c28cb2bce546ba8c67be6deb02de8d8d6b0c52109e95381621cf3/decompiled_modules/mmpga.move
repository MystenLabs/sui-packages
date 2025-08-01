module 0xd50844c8030c28cb2bce546ba8c67be6deb02de8d8d6b0c52109e95381621cf3::mmpga {
    struct MMPGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMPGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMPGA>(arg0, 6, b"MMPGA", b"MAKE MOVE PUMP GREAT AGAIN", b"MPMGA is breathing life back into the page that built Suis giants. Not Move Pump official token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdssdfdsfdsf_3713cc219a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMPGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMPGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

