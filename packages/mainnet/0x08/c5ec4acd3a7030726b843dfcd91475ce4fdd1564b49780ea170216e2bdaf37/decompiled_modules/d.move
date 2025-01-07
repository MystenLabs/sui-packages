module 0x8c5ec4acd3a7030726b843dfcd91475ce4fdd1564b49780ea170216e2bdaf37::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 9, b"D", b"DOGS ", x"426520726561647920746f2074726176656c2ef09f90950a0a3320737461676573206f662061697264726f7020746f20686f6c64657273f09f90b60a0a4c6574277320676f20746f20746865206d6f6f6ef09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6dd3729d-2984-40a1-9b5e-9f3054254920.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D>>(v1);
    }

    // decompiled from Move bytecode v6
}

