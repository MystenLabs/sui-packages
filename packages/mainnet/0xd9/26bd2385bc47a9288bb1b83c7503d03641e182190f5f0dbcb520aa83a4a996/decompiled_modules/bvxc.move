module 0xd926bd2385bc47a9288bb1b83c7503d03641e182190f5f0dbcb520aa83a4a996::bvxc {
    struct BVXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVXC>(arg0, 9, b"BVXC", b"BD", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fba0ae9d-44ff-463d-b8de-008aac7a0659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

