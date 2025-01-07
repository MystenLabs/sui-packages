module 0xc0b31583f26ce0b902b88ae239b167d47172f8ccad2f44378a465632185cdcac::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGO>(arg0, 9, b"SUIGO", b"SUI-Go Tok", x"546f6b656e207468617420426f6f6d206c617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2a500ed-ea29-4460-b8e2-0121c0a16a3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

