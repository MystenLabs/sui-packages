module 0x7ae701aa4f100e67c08bacc6f3e0baed4757348cffefe233d2b87b84653a7517::ade {
    struct ADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE>(arg0, 9, b"ADE", b"Ade9313", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1964b3bc-0ef2-4640-9fce-a67e212eb4f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

