module 0xa5ca25acbdc01d1560831ceda636b09d0d9be4ca1c5baf934b34253835e3c388::mumi {
    struct MUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMI>(arg0, 6, b"MUMI", b"MUMI SUI", b"There is a new sheriff in town, $MUMIinspired by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T7k_V_Wqn_Z_400x400_f1e925b67d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

