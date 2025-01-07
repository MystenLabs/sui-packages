module 0x183fde8b2287858ac96f6edf76fcbcdcc1ae8e6047749586c6c2a9bf931aff9e::suishuba {
    struct SUISHUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHUBA>(arg0, 9, b"SUISHUBA", b"SUISHUBA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.search.brave.com/jGUDPpjRy5ZmLcrV6iYZeC4aF0b-RiAfOc1kMrQdD14/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMuY3J5cHRvLnJv/L2xvZ29zL3N1aS1z/dWktbG9nby5wbmc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHUBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHUBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

