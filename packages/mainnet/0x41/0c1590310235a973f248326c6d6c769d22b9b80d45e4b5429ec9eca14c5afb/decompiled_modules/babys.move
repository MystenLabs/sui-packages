module 0x410c1590310235a973f248326c6d6c769d22b9b80d45e4b5429ec9eca14c5afb::babys {
    struct BABYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYS>(arg0, 9, b"BABYS", b"BabySui", b"Cool token BabySui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cabceeab-54db-4ac9-9383-68cbdd5945f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

