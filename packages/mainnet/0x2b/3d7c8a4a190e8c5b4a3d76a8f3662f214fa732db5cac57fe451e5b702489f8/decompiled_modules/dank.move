module 0x2b3d7c8a4a190e8c5b4a3d76a8f3662f214fa732db5cac57fe451e5b702489f8::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"DankKoin", b"For all the DANK community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifakqkqhh64nege3qo7ne5exw3w6adrc3uvvcsem26bjqpzauga4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DANK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

