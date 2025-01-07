module 0x5f59e26f62b83778cc88341a35b8e7eb57cf5aa7b602695265db2eacccd375de::sbdnsnd {
    struct SBDNSND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBDNSND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBDNSND>(arg0, 9, b"SBDNSND", b"Syshhs", b"Shdjsjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/614821cb-c8df-40b8-98ba-5d5651cc4b2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBDNSND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBDNSND>>(v1);
    }

    // decompiled from Move bytecode v6
}

