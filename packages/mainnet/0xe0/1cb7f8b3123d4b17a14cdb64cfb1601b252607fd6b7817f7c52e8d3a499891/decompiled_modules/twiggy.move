module 0xe01cb7f8b3123d4b17a14cdb64cfb1601b252607fd6b7817f7c52e8d3a499891::twiggy {
    struct TWIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIGGY>(arg0, 6, b"TWIGGY", b"Waterskiing Squirrel TWIGGY", x"54686520776f726c642066616d6f757320545749474759210a546865207761746572736b69696e6720537175697272656c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001239_3cb7aadc27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

