module 0x9847827a94c6c2c00511fc8bb6ca524d1f8e3f54eda7f55ca4e77d61fe5313d9::bambycoin {
    struct BAMBYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMBYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBYCOIN>(arg0, 9, b"BAMBYCOIN", b"Bamby", x"42616d62792120446f672069732070617469656e746c7920484f4c44494e472069747320626167732ef09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/750abe31-6d57-4754-9bb1-01d1ddbe5dfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

