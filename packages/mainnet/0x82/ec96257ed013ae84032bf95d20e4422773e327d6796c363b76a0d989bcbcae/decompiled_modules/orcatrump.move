module 0x82ec96257ed013ae84032bf95d20e4422773e327d6796c363b76a0d989bcbcae::orcatrump {
    struct ORCATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1783462026652-6af6f3cfa654bc212d4b865a9628f429.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1783462026652-6af6f3cfa654bc212d4b865a9628f429.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<ORCATRUMP>(arg0, 6, b"ORCATRUMP", b"Orca Trump", x"4f726361205472756d702020f09f87baf09f87b820496e73706972656420627920446f6e616c64205472756d702c0a546865206e6578742077617665206f66206d656d6573206f6e205375692e0a536974653a2068747470733a2f2f6f7263617472756d702e66756e0a54656c656772616d3a2068747470733a2f2f742e6d652f4f7263617472756d700a583a2068747470733a2f2f782e636f6d2f4f7263617472756d70", v1, arg1);
        let v4 = v2;
        if (1000000000000000 > 0) {
            0x2::coin::mint_and_transfer<ORCATRUMP>(&mut v4, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCATRUMP>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORCATRUMP>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

