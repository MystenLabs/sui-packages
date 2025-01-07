module 0x4e8d3ee0ff620c7d107c96e0ef11307460676ec14004163549320148a35334f1::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 9, b"KABOSU", b"KABOSUI", b"Kabosu, the Shiba Inu whose image became synonymous with the Dogecoin cryptocurrency and the \"Doge\" meme, passed away recently, leaving behind a legacy that transcended the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e025fd36-dd69-4539-bf46-740de8789e49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

