module 0x87a0ce24f4d374af8280eceea598aeb54b68f15661c0e0200dccfa953a1b11cd::fism {
    struct FISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISM>(arg0, 9, b"FISM", b"Fish Man", b"A Meme for everybody", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/579a3591-4c64-4dec-a2b5-8ce0344f7e90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

