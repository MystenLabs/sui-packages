module 0xe60890772fb79f47daab334af257212d203180e06e7d8d896cbc182c67a64886::traxex {
    struct TRAXEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAXEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAXEX>(arg0, 9, b"TRAXEX", b"Sylvanas", b"Look Who's Back. Big Queen , Mistress Sylvanas . She Came Back From Depths Of Hell . Only A Few Gamers Know Her. Respect Her And Buy Her Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05b678f3-f1f1-426d-8c5e-49684cb65280.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAXEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRAXEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

