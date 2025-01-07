module 0x5721a09b47c87d0998669f1c2d9eb3abe46cbca7e4d472618944bd32830865d0::aww {
    struct AWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWW>(arg0, 9, b"AWW", b"arwewe", b"Yes Ser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed1538cb-fda1-439e-a309-cb9e959afc2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

