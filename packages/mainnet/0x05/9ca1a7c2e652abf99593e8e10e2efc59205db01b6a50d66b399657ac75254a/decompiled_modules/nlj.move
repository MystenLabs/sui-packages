module 0x59ca1a7c2e652abf99593e8e10e2efc59205db01b6a50d66b399657ac75254a::nlj {
    struct NLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLJ>(arg0, 9, b"NLJ", b"NELSON", b"A COIN FOR THE FUTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78a3f04f-cb92-4167-91fd-c1e87e8c379c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

