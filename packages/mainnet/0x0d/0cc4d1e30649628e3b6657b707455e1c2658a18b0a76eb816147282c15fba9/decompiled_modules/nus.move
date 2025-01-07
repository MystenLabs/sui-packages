module 0xd0cc4d1e30649628e3b6657b707455e1c2658a18b0a76eb816147282c15fba9::nus {
    struct NUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUS>(arg0, 9, b"NUS", b"Nussy", b"Scream This project is about improving and modernizing the movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fbfefce-0276-4439-a156-944c1b78f54c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

