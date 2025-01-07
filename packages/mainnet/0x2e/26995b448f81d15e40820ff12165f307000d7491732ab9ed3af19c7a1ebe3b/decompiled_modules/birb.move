module 0x2e26995b448f81d15e40820ff12165f307000d7491732ab9ed3af19c7a1ebe3b::birb {
    struct BIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRB>(arg0, 6, b"BIRB", b"Birb Cto", x"6a7573742061206c696c206269726220696e20612062696720626c756520736b79200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ajuuf_Wi_400x400_dc4e8a9f5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

