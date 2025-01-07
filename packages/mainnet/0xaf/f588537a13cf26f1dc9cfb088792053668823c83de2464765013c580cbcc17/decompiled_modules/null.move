module 0xaff588537a13cf26f1dc9cfb088792053668823c83de2464765013c580cbcc17::null {
    struct NULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NULL>(arg0, 9, b"NULL", b"null", b"The NULL Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/236feb90-e5e3-4303-9692-03cb0fa63c5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

