module 0x80adf89908b11ab351f0cef89f8b03ffd0a79c7a762d153ea3bd2a03f5eddd93::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 9, b"HA", b"Harry", b"A Good And Evil Man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1268856-0331-4aac-b9a2-da3c04a9c1ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
    }

    // decompiled from Move bytecode v6
}

