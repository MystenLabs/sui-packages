module 0xc6221a9e4ce0ee4375e9f3829a642b7ca39e62f0cdaf980a603ed8263cb5bce0::mpt {
    struct MPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPT>(arg0, 9, b"DOG", b"Dog", b"ALL Dogs are my love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxj5gx37b3fothpvnd74uv5ji74j7lwjrczetl25ldkkktxr6tgy?X-Algorithm=PINATA1&X-Date=1732068477&X-Expires=315360000&X-Method=GET&X-Signature=87683274dc6efa646a9a9d5db68a42483b7678a169f1a793c98ac811c263f0be"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MPT>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MPT>>(v2);
    }

    // decompiled from Move bytecode v6
}

