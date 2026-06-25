module 0xd04ff39ced49be2e927382604d49450cea51835689c53bb19391dfd8a90c5392::hhASUI {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hhASUI", b"hhASUI Coin", b"hhASUI Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/lend/lend-vault/coin-icons/hhasui_c93449f8.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

