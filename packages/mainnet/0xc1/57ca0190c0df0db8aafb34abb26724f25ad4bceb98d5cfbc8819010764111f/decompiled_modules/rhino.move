module 0xc157ca0190c0df0db8aafb34abb26724f25ad4bceb98d5cfbc8819010764111f::rhino {
    struct RHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINO>(arg0, 6, b"Rhino", b"Angry Rhino", b"Smashing its way through the Sui and Aptos ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6424_658572a93b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

