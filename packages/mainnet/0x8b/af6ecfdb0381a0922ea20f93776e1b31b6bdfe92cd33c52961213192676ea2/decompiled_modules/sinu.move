module 0x8baf6ecfdb0381a0922ea20f93776e1b31b6bdfe92cd33c52961213192676ea2::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINU>(arg0, 6, b"SINU", b"Sui Inu", b"Sui Inu- the water dog of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K3_HE_Jo_X5_400x400_4147da7e5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

