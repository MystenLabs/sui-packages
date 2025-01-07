module 0xd213e4e01a07d5e58f381f0c58b09691a60e1d08e92386c115ad4254a128b603::StaffofElerianGrace {
    struct STAFFOFELERIANGRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAFFOFELERIANGRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAFFOFELERIANGRACE>(arg0, 0, b"COS", b"Staff of Elerian Grace", b"The Aurahma have crafted a mystical Solana staff to celebrate the first collection minted on Solana in October 2022!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Staff_of_Elerian_Grace.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAFFOFELERIANGRACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAFFOFELERIANGRACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

