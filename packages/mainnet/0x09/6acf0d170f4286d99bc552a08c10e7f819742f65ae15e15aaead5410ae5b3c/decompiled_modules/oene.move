module 0x96acf0d170f4286d99bc552a08c10e7f819742f65ae15e15aaead5410ae5b3c::oene {
    struct OENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENE>(arg0, 9, b"OENE", b"hebe", b"vdbs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e164187-84ea-455e-b432-39712c7d953d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

