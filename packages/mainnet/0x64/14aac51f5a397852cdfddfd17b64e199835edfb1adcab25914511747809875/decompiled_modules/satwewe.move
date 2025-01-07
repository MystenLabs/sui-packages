module 0x6414aac51f5a397852cdfddfd17b64e199835edfb1adcab25914511747809875::satwewe {
    struct SATWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATWEWE>(arg0, 9, b"SATWEWE", b"Satoshi We", b"Satoshi Wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/694a3185-2f27-47ed-8d5c-b857ad59f21f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

