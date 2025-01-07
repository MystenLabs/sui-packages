module 0x19824528848814b081b56b0ae1029b91e92a5bfdc65ae678c6be326def58a179::sailormoon {
    struct SAILORMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAILORMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAILORMOON>(arg0, 9, b"SAILORMOON", b"Sailor", b"Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89fb1b8d-c656-4414-ba6c-8d3a37bbceb1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAILORMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAILORMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

