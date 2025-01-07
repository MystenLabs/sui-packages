module 0x32f0b5a6e80b5208f5168b699beb0df08749d8bdbc620f5d496b0a233db09751::phug {
    struct PHUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHUG>(arg0, 6, b"PHUG", b"Phug on Sui", b"Sui favorite pug. Enter the phugverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055524_43f6e4084b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

