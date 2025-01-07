module 0x4dca7489c8783e7209459bd41a51d41c36fe7dcacee6f94ab158b93d7e84bebc::sui_kermit {
    struct SUI_KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_KERMIT>(arg0, 9, b"Sui Kermit", b"Kermin On Sui", b"Kermis Is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844421991320911876/2LYcCmUv.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_KERMIT>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_KERMIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

