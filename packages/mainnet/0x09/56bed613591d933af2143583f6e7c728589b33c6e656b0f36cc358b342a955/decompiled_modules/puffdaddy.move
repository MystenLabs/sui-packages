module 0x956bed613591d933af2143583f6e7c728589b33c6e656b0f36cc358b342a955::puffdaddy {
    struct PUFFDADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFDADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFDADDY>(arg0, 9, b"PUFFDADDY", b"SEAN COMBS", b"RAPPER EXTRAORDINAIRE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFFDADDY>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFDADDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFDADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

