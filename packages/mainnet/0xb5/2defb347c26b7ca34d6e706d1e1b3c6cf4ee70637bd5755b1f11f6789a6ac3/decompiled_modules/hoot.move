module 0xb52defb347c26b7ca34d6e706d1e1b3c6cf4ee70637bd5755b1f11f6789a6ac3::hoot {
    struct HOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOT>(arg0, 6, b"HOOT", b"Hoot on Sui", b"(Relaunched) NFT and TG snipe bot project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731378931639.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

