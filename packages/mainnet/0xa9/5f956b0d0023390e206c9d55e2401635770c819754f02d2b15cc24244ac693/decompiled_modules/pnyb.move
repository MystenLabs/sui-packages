module 0xa95f956b0d0023390e206c9d55e2401635770c819754f02d2b15cc24244ac693::pnyb {
    struct PNYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNYB>(arg0, 9, b"PNYB", b"PonyBit", b"PonyBit (PNYB) is an innovative cryptocurrency token inspired by the grace and power of horses. Designed for use in decentralized ecosystems, PonyBit symbolizes speed, freedom, and sustainable development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17cda207-7369-4981-8e6f-5a359a629e81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNYB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

