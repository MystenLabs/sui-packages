module 0x1b7115653729c57dd32f616d9012e52ff71feb833e0b88d5b4c6c577d162a8c6::mgodl {
    struct MGODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGODL>(arg0, 9, b"MGODL", b"Memegodl", b"Let's call this memegodl and let's make it a fun coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ebc7332-29da-4ab8-9e3c-54cb34bec795.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

