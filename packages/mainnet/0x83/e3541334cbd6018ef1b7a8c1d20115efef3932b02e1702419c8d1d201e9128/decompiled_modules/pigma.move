module 0x83e3541334cbd6018ef1b7a8c1d20115efef3932b02e1702419c8d1d201e9128::pigma {
    struct PIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGMA>(arg0, 6, b"PIGMA", b"Pepe Sigma", b"Pepe Sigma is finally here. You guys probably know my Pepe Brothers, and now it's my time to shine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048727_5293ee039b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

