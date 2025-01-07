module 0x740657fb42ee9126af2d7534ce45da6529e001cdb465ffe95699f58740a6883b::ne {
    struct NE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NE>(arg0, 9, b"NE", b"Nene", b"Nene cat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9300c3a-81fb-448b-bc17-b6a61068d815.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NE>>(v1);
    }

    // decompiled from Move bytecode v6
}

