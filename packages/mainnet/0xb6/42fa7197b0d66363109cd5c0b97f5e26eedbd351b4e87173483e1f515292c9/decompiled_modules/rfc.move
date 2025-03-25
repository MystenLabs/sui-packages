module 0xb642fa7197b0d66363109cd5c0b97f5e26eedbd351b4e87173483e1f515292c9::rfc {
    struct RFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFC>(arg0, 9, b"RFC", b"Retard Finder Coin", b"The most retarded coin in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmbi9jsNn718gvh85C2vuj4CSsu5JmuYq1W7B1vk2ys88W")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RFC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

