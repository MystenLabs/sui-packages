module 0xa38b882bc4b3acfd1a803db12e4c04d9543546169e33d4ea2f944f7921344a3a::bwf {
    struct BWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWF>(arg0, 9, b"BWF", b"BabyWifHat", b"Cute baby with hat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31c37946-0e16-4766-a37d-b909c9924bff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

