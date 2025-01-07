module 0xcd980f33ab6e60571dd861dd5e8045967721f7431bf973dc7853b665d5f20655::bv {
    struct BV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BV>(arg0, 9, b"BV", b"GF", b"VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8ac7502-ef7b-4816-9479-2d758cc72eb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV>>(v1);
    }

    // decompiled from Move bytecode v6
}

