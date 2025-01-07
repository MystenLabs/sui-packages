module 0xe19e03f5a101fea4906b18dd600902b7e8283331a8ab7ac16cee960bd7ba7f83::jgtr {
    struct JGTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGTR>(arg0, 9, b"JGTR", b"Jugator ", b"Only real Jugators can understand each other ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b56bfcc-c2b3-4fb4-8a82-89219afb59d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

