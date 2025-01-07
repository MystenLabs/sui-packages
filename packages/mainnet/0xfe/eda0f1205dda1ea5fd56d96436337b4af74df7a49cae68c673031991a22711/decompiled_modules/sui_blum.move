module 0xfeeda0f1205dda1ea5fd56d96436337b4af74df7a49cae68c673031991a22711::sui_blum {
    struct SUI_BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_BLUM>(arg0, 9, b"Sui BLUM", b"Blum On Sui", b"Your easy, fun crypto trading app for buying and trading any crypto on the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843749862053163008/2ULVg4Hc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_BLUM>(&mut v2, 4509900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_BLUM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

