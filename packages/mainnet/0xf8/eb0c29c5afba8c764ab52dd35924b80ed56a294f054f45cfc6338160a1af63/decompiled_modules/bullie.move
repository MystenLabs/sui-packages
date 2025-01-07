module 0xf8eb0c29c5afba8c764ab52dd35924b80ed56a294f054f45cfc6338160a1af63::bullie {
    struct BULLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLIE>(arg0, 9, b"BULLIE", b"Bullie Dog", x"2442756c6c696520697320612063757465206c6974746c6520646f6720f09f90b6204d656d65636f696e2042756c6c69652077616e747320746f20676f20746f20746865206d6f6f6f6f6f6f6ef09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a147353a-2b88-4668-a58e-d3e0c315e229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

