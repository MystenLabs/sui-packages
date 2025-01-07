module 0xa1f6fd30d1807ec607358014312e547a36b1722e2a3c18f3fb2954500ff7a2b1::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"SUI DRAGON", b"Introducing SuiDragon, the blazing hot new meme token taking the crypto world by storm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Wd_Kju_EJ_400x400_edb002cd70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

