module 0x788dbb4107e91b801d4f4b59cd3a96ff9769358230930030bf6f29fe404af9df::sui_fomo {
    struct SUI_FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_FOMO>(arg0, 9, b"Sui Fomo", b"Father Of Meme On Sui", b"Father Of Meme On Sui - SFOMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843387763183468544/d7dxTrOz.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_FOMO>(&mut v2, 2500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_FOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

