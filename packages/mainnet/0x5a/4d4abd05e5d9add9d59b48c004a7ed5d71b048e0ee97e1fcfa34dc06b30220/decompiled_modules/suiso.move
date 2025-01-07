module 0x5a4d4abd05e5d9add9d59b48c004a7ed5d71b048e0ee97e1fcfa34dc06b30220::suiso {
    struct SUISO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISO>(arg0, 6, b"Suiso", b"Suiso Hydrogen H2", b"Suiso, the enigmatic spirit of hydrogen, fuels the future with its endless energy, bringing a breath of fresh air to the world of innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8413894_007bd9a936.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISO>>(v1);
    }

    // decompiled from Move bytecode v6
}

