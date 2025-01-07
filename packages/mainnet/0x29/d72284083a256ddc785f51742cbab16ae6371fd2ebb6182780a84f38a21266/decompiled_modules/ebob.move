module 0x29d72284083a256ddc785f51742cbab16ae6371fd2ebb6182780a84f38a21266::ebob {
    struct EBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBOB>(arg0, 9, b"EBOB", b"SPONG", b"SPONGEBOB REFRIGERATOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ca546a1-1d58-4d35-befe-e483a586b89e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

