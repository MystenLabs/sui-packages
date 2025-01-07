module 0x1ca148de7541087035fd02e0022339f87d696781125b154fa6f93faca59df42::badakgede {
    struct BADAKGEDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADAKGEDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADAKGEDE>(arg0, 9, b"BADAKGEDE", b"BADAK", b"Badak kewan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be794e40-b734-47bc-802c-286e8a0e3be6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADAKGEDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADAKGEDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

