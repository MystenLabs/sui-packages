module 0x294a593dc0e84d911a63e456392e5f57af584d6382e272d5e15c078055e4fe1a::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 9, b"Gm", b"GoodMorning", b"what you need to say in the morning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3Ku3V94EVH9Arvun63VrHs-vBtP-omlffnOJq1EGG10ru0vj2PAKOMfsyRN5TrO-UInQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

