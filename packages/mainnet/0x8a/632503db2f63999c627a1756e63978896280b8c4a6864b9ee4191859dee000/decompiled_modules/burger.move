module 0x8a632503db2f63999c627a1756e63978896280b8c4a6864b9ee4191859dee000::burger {
    struct BURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURGER>(arg0, 6, b"BURGER", b"SUI Burger", b"Inspired by a viral moment of Trump saying \"crypto burger\", this token is cooking up something big in the blockchain space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_110916_3392665ecd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

