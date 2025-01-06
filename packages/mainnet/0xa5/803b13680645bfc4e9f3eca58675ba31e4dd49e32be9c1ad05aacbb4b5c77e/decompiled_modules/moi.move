module 0xa5803b13680645bfc4e9f3eca58675ba31e4dd49e32be9c1ad05aacbb4b5c77e::moi {
    struct MOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOI>(arg0, 9, b"MOI", b"POOPAK", b"PPOOPAKMORADII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a56efd8e-3734-4b73-9a2a-3e944fb280d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

