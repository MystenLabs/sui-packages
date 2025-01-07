module 0xc46bd60ba19724803f4fe56957f0a99eef924e3ea198ce9e8dbb490720d17622::penguins {
    struct PENGUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINS>(arg0, 6, b"PENGUINS", b"SUI PENGUINS", b"Sui Penguins  | The Coolest Waddle on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/penguin_7daae6d417.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

