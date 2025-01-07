module 0x258c739c204b2142c5237671c253e29c849b347296cfbf965a08bf225fd1c3be::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 9, b"JELLY", b"suijellyfish", x"54686520637574657374206d656d65636f696e207377696d6d696e67206f6e207468652053756920426c6f636b636861696e20f09f8c8af09f9099202068747470733a2f2f7777772e7375696a656c6c79666973682e66756e2f202068747470733a2f2f742e6d652f7375696a656c6c7966697368706f7274616c202068747470733a2f2f782e636f6d2f7375696a656c6c796669736878", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728707219755-57982bd9b95f7e193999627fee0b7fdf.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v2, @0xbd32063a0ebc6b05035a55d4442a5ac64b226e97af7e24c5ccc9c7f18565583c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

