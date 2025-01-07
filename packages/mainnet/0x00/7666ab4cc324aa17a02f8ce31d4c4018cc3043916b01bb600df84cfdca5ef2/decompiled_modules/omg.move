module 0x7666ab4cc324aa17a02f8ce31d4c4018cc3043916b01bb600df84cfdca5ef2::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 6, b"OMG", b"OMGSUI", b"OMG... you got this... again ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ur_Lk2fl_400x400_copy_4029e3411d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

