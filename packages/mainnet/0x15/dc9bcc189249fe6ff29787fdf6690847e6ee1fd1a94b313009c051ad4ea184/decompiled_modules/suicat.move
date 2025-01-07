module 0x15dc9bcc189249fe6ff29787fdf6690847e6ee1fd1a94b313009c051ad4ea184::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 9, b"SUICAT", b"SUICAT", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.search.brave.com/jGUDPpjRy5ZmLcrV6iYZeC4aF0b-RiAfOc1kMrQdD14/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dHMuY3J5cHRvLnJv/L2xvZ29zL3N1aS1z/dWktbG9nby5wbmc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

