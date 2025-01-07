module 0xd88628c7353eb36f4c3a8df9d4f020189812f30268e10b2cc46752ed36bdd8f2::brk {
    struct BRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRK>(arg0, 9, b"BRK", b"Brick", b"Build your dream home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a95a1590-58cf-4198-ae50-071d63be8f72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

