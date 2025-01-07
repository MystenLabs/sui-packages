module 0xe1a1ede2959a391b6ea8dce5289c7c1dcfbe8dd81ca366c5bdadb2bbc0c83f29::spn {
    struct SPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPN>(arg0, 9, b"SPN", b"scorpion", b"Very toxic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c699ca7-ee2f-4dda-82d1-cf5a872eb380.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

