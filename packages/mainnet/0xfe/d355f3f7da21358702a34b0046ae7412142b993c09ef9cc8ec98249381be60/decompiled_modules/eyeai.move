module 0xfed355f3f7da21358702a34b0046ae7412142b993c09ef9cc8ec98249381be60::eyeai {
    struct EYEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYEAI>(arg0, 9, b"EYEAI", b"EYE AI", x"455945414920697320616e206167656e7420666f72206465657020726573656172636820616e6420616e616c79746963732e20f09f91810d0a0d0a204120756e6976657273616c20746f6f6c2074686174206761746865727320616c6c20746865206d6f7374206e656564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUhRXvSAbZpiG2j7UK85J4Kdt6AJbBAM844jz9SXpvSH6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EYEAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYEAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

