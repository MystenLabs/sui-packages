module 0xa19f6301c7b24dca79f581ea11a1a0df00376c1186622e501ac25a60ba81a4aa::blak {
    struct BLAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAK>(arg0, 6, b"BLAK", b"Blak Trump", b"YOUR FAVORITE LEGEND..? PROBABLY... BLAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/ffa988a0-6b1a-40a1-b434-29f8156b8cba.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

