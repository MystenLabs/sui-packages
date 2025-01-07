module 0xc04707853d6b476b22caaecd20532fc9606ec0d3d2e717b45a41e715d26380ea::richiedog {
    struct RICHIEDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RICHIEDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RICHIEDOG>>(0x2::coin::mint<RICHIEDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RICHIEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHIEDOG>(arg0, 6, b"Sui Richie Dog", b"RichieDog", b"Sui Richie Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/4QCuRXhpZgAASUkqAAgAAAADAA4BAgBkAAAAMgAAABoBBQABAAAAlgAAABsBBQABAAAAngAAAAAAAABDdXRlIGNhcnRvb24gZ3JlZW4gYmFieSBkcmFnb24gZmx5aW5nLiBGdW5ueSBsaXR0bGUgY...")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHIEDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHIEDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

