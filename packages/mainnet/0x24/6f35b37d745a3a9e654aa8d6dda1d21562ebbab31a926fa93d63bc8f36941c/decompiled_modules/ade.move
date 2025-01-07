module 0x246f35b37d745a3a9e654aa8d6dda1d21562ebbab31a926fa93d63bc8f36941c::ade {
    struct ADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADE>(arg0, 9, b"ADE", b"Ade9313", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9aa12712-1e20-4283-9c55-57839c66915f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

