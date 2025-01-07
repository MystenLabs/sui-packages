module 0xdfa080074ef7b579f26025f90a5104009debdda1801f1ddb152fe60d99f72bf3::kind {
    struct KIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIND>(arg0, 9, b"KIND", b"Kindly tok", b"This token is created to help the poor. Be kind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fb8a862-a208-4824-af1b-9eb75a1f74eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

