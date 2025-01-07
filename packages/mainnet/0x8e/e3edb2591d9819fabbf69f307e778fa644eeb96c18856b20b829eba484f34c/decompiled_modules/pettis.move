module 0x8ee3edb2591d9819fabbf69f307e778fa644eeb96c18856b20b829eba484f34c::pettis {
    struct PETTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETTIS>(arg0, 9, b"PETTIS", b"SuiPettis", x"46756e6e792053746f7279200a0a0a5765206469642074686973206f6e20747275737420f09fabb620616e642068617665206e6f206964656120776861742068617070656e6564207769746820746865206368616e6e656c202e0a0a0a0a4c6574e280997320676f2c2050455454495321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce3c0b98-eced-48c9-918e-a200f45f9af6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

