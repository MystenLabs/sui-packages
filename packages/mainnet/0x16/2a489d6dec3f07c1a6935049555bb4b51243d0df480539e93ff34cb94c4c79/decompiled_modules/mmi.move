module 0x162a489d6dec3f07c1a6935049555bb4b51243d0df480539e93ff34cb94c4c79::mmi {
    struct MMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMI>(arg0, 9, b"MMI", b"MEMEFI", b"For the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed2e741e-847c-4f79-bc4e-9b9d76feabd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

