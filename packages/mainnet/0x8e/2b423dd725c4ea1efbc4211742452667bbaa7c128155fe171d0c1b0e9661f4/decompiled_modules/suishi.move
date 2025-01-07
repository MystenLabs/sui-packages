module 0x8e2b423dd725c4ea1efbc4211742452667bbaa7c128155fe171d0c1b0e9661f4::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 9, b"SUISHI", b"SUISHI", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.search.brave.com/jGUDPpjRy5ZmLcrV6iYZeC4aF0b-RiAfOc1kMrQdD14/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMuY3J5cHRvLnJv/L2xvZ29zL3N1aS1z/dWktbG9nby5wbmc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

