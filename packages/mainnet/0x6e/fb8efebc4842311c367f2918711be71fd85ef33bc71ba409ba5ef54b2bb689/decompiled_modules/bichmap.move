module 0x6efb8efebc4842311c367f2918711be71fd85ef33bc71ba409ba5ef54b2bb689::bichmap {
    struct BICHMAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BICHMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BICHMAP>(arg0, 9, b"BICHMAP", b"Heheo", b"Wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0af3746b-369c-4bda-a5b6-fc1d0517a61c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BICHMAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BICHMAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

