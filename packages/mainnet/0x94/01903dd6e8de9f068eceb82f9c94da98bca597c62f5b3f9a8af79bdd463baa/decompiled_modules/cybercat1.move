module 0x9401903dd6e8de9f068eceb82f9c94da98bca597c62f5b3f9a8af79bdd463baa::cybercat1 {
    struct CYBERCAT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT1>(arg0, 9, b"CYBERCAT1", b"Cyber cat ", b"Cyber cat is a good token, it is useable by everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13b9a339-6b37-40da-ae3e-83cd5cf343ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERCAT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

