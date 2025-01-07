module 0xf4721b25146b4cd0d1e0db6962780894b97b2d9ed20046e8482ea207ccc8ccfc::deosoai {
    struct DEOSOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEOSOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEOSOAI>(arg0, 9, b"DEOSOAI", b"JunBon04", b"JunBon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb01e030-73ef-463b-83ca-4ffcaddb5d58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEOSOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEOSOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

