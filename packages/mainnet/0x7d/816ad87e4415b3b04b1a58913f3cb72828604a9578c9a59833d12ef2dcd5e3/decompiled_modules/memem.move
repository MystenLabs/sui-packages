module 0x7d816ad87e4415b3b04b1a58913f3cb72828604a9578c9a59833d12ef2dcd5e3::memem {
    struct MEMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEM>(arg0, 9, b"MEMEM", b"Airdrop", b"Spesialis airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25400252-6609-4f46-8e9e-ecc3ff60be90-1000231035.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

