module 0x6e80e72160c5499957b74f4a429023f1fb1b844ce01113bc07f033bab44e7fb7::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"Orca", b"ORCA", b"In the blockchain ocean, the Sui Network's meme orca hunts competitors with sharp wit and viral creativity. Agile and relentless, it embodies Sui's strength, turning humor into power and dominating the crypto waters. Only the clever survive, and this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735890163628.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

