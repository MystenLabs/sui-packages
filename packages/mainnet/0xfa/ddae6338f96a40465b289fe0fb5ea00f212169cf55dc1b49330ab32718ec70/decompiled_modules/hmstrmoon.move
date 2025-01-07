module 0xfaddae6338f96a40465b289fe0fb5ea00f212169cf55dc1b49330ab32718ec70::hmstrmoon {
    struct HMSTRMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTRMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTRMOON>(arg0, 9, b"HMSTRMOON", b"Hmstr Moon", b"Hamster Kombat to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/792f5941-cddf-4e5c-9b18-43d75886568e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTRMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMSTRMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

