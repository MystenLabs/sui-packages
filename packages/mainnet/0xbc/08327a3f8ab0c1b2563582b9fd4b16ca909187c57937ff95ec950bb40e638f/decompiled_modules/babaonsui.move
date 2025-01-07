module 0xbc08327a3f8ab0c1b2563582b9fd4b16ca909187c57937ff95ec950bb40e638f::babaonsui {
    struct BABAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABAONSUI>(arg0, 9, b"BABAONSUI", b"Baba", b"A token for Baba and his family. Babarage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/878ce4ba-3035-4625-80ed-8d85b1694872.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

