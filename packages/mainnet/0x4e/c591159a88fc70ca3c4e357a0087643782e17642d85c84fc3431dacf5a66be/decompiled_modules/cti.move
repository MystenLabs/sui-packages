module 0x4ec591159a88fc70ca3c4e357a0087643782e17642d85c84fc3431dacf5a66be::cti {
    struct CTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTI>(arg0, 9, b"CTI", b"Cryptonomi", b"This token was created for transactions and finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/197c1bee-384b-42e2-9536-4f5fbe3e7962.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

