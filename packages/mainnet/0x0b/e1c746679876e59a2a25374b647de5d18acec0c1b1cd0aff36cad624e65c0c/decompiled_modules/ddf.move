module 0xbe1c746679876e59a2a25374b647de5d18acec0c1b1cd0aff36cad624e65c0c::ddf {
    struct DDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDF>(arg0, 9, b"DDF", b"DoDaFu", b"Nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/334c08b7-05c1-4df9-b494-ec2795028e5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

