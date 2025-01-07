module 0x80c5376667baae7c0dc297c429c1ec6ecafa466e3f8099a88744d6037ca0df04::slsl {
    struct SLSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLSL>(arg0, 6, b"SLSL", b"SILKY SEAL", b"Smooth, shiny, and unstoppable in the water of gains. Silky Seal is making waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_054339759_d8b5d487ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

