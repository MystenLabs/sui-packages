module 0xfad9dd9bcf698eddd3ef42505f85240f1e5109ff364c71dd1a2cbf103b3848a::wht {
    struct WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<WHT>(arg0, 6, b"WHT", b"white", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgABAABXRUJQVlA4WAoAAAAQAAAA/wAA/wAAQUxQSB0AAAABDzD/ERHCTNs2+caf6RgYRiP6H9UDAABcNf8HPgBWUDggvAAAAHATAJ0BKgABAAE+bTaYSKQjIqEkKACADYlpbuF2ARtA5Z/IPWBZAjp1ZFX56wLHEOzS/nrAsgmktp0+sCyChphtiHgLIKGyMXEiW/6zMVr6cEw3ChskXK6ZmLiuyRcsgR06sir89YFjiHZpfz1gWQTSW06fWBZBQ0w2xDwFkFDZGLiRLf9ZmK19OCYbhQ2SLldMzFxXZIuWQI6dWRV+esCxxDAAAP7/wc7D//2/t+dv//27YAAAAAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

