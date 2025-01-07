module 0xd63ec60fa7b534d5c20996fad9b7f4694831584bc17c15fa77d2b263a9bd4a55::ishaq {
    struct ISHAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHAQ>(arg0, 9, b"ISHAQ", b"Wellshi ", b"Great project for all we've users ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/284e6df5-578b-4de5-8099-e1bc27f63b1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISHAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

