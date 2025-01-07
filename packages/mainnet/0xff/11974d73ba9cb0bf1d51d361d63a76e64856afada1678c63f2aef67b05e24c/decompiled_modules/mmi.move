module 0xff11974d73ba9cb0bf1d51d361d63a76e64856afada1678c63f2aef67b05e24c::mmi {
    struct MMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMI>(arg0, 9, b"MMI", b"Momi", b"Mmi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0d9fa31-702e-4e77-827c-bc08bedecf41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

