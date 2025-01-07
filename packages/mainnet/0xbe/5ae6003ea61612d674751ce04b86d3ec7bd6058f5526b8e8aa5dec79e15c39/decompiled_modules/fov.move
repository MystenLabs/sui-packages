module 0xbe5ae6003ea61612d674751ce04b86d3ec7bd6058f5526b8e8aa5dec79e15c39::fov {
    struct FOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOV>(arg0, 9, b"FOV", b"FOV.", b"An innovative solution for administering Telegram groups, combining powerful management tools with an integrated wallet for seamless transactions and monetization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c17c738-d699-415d-8fd4-29ed9b20c588.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

