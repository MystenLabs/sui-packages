module 0x6757288fd71c7cb7ad5708b04263990341df86a45833937ecea486aab3a13fc6::smolsui {
    struct SMOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLSUI>(arg0, 6, b"SmolSui", b"Smol SUI", b"unofficial official meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xm_Crdg_Lu_400x400_b6df913cf5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

