module 0xada297c9468fa9bb42cfedd77f897902d1d7f796e433d9c18063aee8bedcd5f3::suiggy {
    struct SUIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGY>(arg0, 6, b"SUIGGY", b"Suiggy On Sui", x"0a546865206d656d6520636f696e207769746820736f206d75636820737761672c206576656e20796f75722063727970746f0a77616c6c65742077696c6c20666c65782e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gr_t_As_LA_400x400_8e72cd673e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

