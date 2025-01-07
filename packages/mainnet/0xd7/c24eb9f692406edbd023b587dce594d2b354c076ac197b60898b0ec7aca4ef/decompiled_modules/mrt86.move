module 0xd7c24eb9f692406edbd023b587dce594d2b354c076ac197b60898b0ec7aca4ef::mrt86 {
    struct MRT86 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRT86, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRT86>(arg0, 9, b"MRT86", b"MRT", b"MRT is a meme so funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58874c8a-fdad-4438-8afc-73a5d302b9c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT86>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRT86>>(v1);
    }

    // decompiled from Move bytecode v6
}

