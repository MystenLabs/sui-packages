module 0xca2b393831abf8981089f610fcf14fcdf5c2ae57338cb47117549447f08b9eb::r_sgm {
    struct R_SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_SGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_SGM>(arg0, 9, b"R_SGM", b"ryan sigma", b"This is crypto friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/569997ff-4de5-4d2d-be99-0219d985f832.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_SGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R_SGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

