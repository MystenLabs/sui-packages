module 0x8b37b4fa2ee16614353e4693e242f6df6152d677b4780584c73aa02e8020259a::moment {
    struct MOMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMENT>(arg0, 9, b"MOMENT", b"KEEPGOING", b"We keepgoing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2aeccfc-58e1-44d6-8436-000ae47ea3b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

