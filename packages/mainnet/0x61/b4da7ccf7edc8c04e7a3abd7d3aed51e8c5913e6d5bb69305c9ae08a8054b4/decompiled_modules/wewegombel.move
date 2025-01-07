module 0x61b4da7ccf7edc8c04e7a3abd7d3aed51e8c5913e6d5bb69305c9ae08a8054b4::wewegombel {
    struct WEWEGOMBEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEGOMBEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEGOMBEL>(arg0, 9, b"WEWEGOMBEL", b"Wewegombel", b"Wewegombel setan orang indo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bb00dbe-92c0-401c-bc79-517650ead3e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEGOMBEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEGOMBEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

