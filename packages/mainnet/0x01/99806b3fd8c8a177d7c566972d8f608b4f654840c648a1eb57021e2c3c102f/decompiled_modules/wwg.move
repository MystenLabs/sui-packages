module 0x199806b3fd8c8a177d7c566972d8f608b4f654840c648a1eb57021e2c3c102f::wwg {
    struct WWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWG>(arg0, 9, b"WWG", b"Gombel", b"The most popular ghost in Indonesia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94d6bf9f-9c33-4f32-8e69-01c47ed04f8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

