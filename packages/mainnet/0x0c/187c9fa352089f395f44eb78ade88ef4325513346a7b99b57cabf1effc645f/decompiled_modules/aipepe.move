module 0xc187c9fa352089f395f44eb78ade88ef4325513346a7b99b57cabf1effc645f::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 9, b"AIPEPE", b"AI PEPE", b"AI + PEPE = AIPEPE. AI PEPE is the largest AI Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmYNWGfWx5LPyeufRS8z8LH1r6rtPPWHeuETQxCY9KAhcT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

