module 0xbfc1077e91a0afad0346e033e8abaa639544c40256c919f9c117de54076ce437::suimeocat {
    struct SUIMEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOCAT>(arg0, 9, b"SUIMEOCAT", b"Suimeo cat", b"Rizz cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e4a8ac3-445c-4f89-983f-e74cceec85de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

