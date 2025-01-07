module 0x8788cb2105f0b7b35483bdc7172ec41969de8a08f9273a5df900f7389b592edf::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 9, b"FUD", b"FED", b"Hfjfhjjbdjnjhvdfgggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d876e867-e1d0-4716-a534-0ae8705b8a32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

