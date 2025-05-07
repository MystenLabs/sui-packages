module 0x4e6d42dec0dc44e7547aeb1dfcf025cb2c216675a414020849e0bb0b70d2f923::cee {
    struct CEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEE>(arg0, 6, b"Cee", b"Central Cee", b"Band4Band  yo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictqcxqak2jcdjci7gbctdtx4b7afka75xfqn2fbv33d5x44vzaku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

