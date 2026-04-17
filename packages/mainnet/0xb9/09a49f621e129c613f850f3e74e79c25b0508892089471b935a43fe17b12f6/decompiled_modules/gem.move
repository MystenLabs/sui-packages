module 0xb909a49f621e129c613f850f3e74e79c25b0508892089471b935a43fe17b12f6::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 9, b"GEM", b"Gem", b"Gem Sui Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776441643757-b688b0dd2f091de3451c7534098ccdc0.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GEM>>(0x2::coin::mint<GEM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

