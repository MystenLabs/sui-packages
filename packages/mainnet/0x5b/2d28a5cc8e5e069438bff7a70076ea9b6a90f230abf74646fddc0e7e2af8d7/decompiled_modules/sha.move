module 0x5b2d28a5cc8e5e069438bff7a70076ea9b6a90f230abf74646fddc0e7e2af8d7::sha {
    struct SHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA>(arg0, 9, b"SHA", b"SHA", b"SHA256", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.shopify.com/s/files/1/2281/6067/files/dogwifhat_sticker.png?v=1702942834")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHA>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

