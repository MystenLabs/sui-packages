module 0xe13c0314ef28a05da5278388a0463a427d5d2c719fa32649078e1c6ebe5e70fe::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"Stonksons", x"41204c616d626f206973206e6f742061206c75787572792069742069732061206e656365737369747920616e64206f6e65206461792065766572796f6e652077696c6c206861766520746865206f70706f7274756e69747920746f206f776e2061204c616d626f207468726f7567682053746f6e6b736f6e7321210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stonkson_ebf8edfcb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

