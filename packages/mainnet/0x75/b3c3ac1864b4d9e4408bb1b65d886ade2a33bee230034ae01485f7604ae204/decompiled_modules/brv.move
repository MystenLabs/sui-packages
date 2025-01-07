module 0x75b3c3ac1864b4d9e4408bb1b65d886ade2a33bee230034ae01485f7604ae204::brv {
    struct BRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRV>(arg0, 9, b"BRV", b"Brave", b"Be brave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c651dcdc-7994-4fd1-be74-58c173eb83db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRV>>(v1);
    }

    // decompiled from Move bytecode v6
}

