module 0xbee65f7575776cfa5dd09cf18446621fe53bf261dbcb0868b1f36796cc1f4c5d::babyor {
    struct BABYOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYOR>(arg0, 6, b"BABYOR", b"Baby Gorbagana", b"The Cutest Trash on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavlifef7jcl43vhggb3ctdrrjxi5txm4ojaum6g3q263hd44bevy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

