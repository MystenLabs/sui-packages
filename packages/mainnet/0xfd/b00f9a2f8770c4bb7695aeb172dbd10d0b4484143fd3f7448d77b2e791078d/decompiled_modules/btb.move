module 0xfdb00f9a2f8770c4bb7695aeb172dbd10d0b4484143fd3f7448d77b2e791078d::btb {
    struct BTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTB>(arg0, 9, b"BTB", b"BITBOY", b"Welcome to BitBoy Crypto. Home of the BitSquad. The Largest & Greatest Crypto Community in all the inter webs. BITBOY IS BACK ON SUI. Let's get it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98930305-fd57-4412-9a89-0036953108bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

