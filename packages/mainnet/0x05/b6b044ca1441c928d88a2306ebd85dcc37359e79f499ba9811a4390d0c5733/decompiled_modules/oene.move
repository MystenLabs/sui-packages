module 0x5b6b044ca1441c928d88a2306ebd85dcc37359e79f499ba9811a4390d0c5733::oene {
    struct OENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENE>(arg0, 9, b"OENE", b"jejd", b"jend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a17649ae-7309-4815-b403-6424e2dc1aa9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

