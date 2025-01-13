module 0xe3ce4732e5605a9027fd3d699522c34dc7ca222fa8c80377cde5c8abade027df::slma {
    struct SLMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLMA>(arg0, 6, b"SLMA", b"SUILAMA  by SuiAI", x"537569204d6173636f7420f09fa6992e412067656e746c65204c6c616d6120726561647920746f2068697373207370697420616e64206b69636b207468726f75676820746865205375692065636f73797374656d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ofa_Iivp_Y_400x400_c9270be58e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLMA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLMA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

