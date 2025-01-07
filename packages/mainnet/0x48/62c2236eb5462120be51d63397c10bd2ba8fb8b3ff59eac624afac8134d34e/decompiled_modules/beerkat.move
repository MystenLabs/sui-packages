module 0x4862c2236eb5462120be51d63397c10bd2ba8fb8b3ff59eac624afac8134d34e::beerkat {
    struct BEERKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERKAT>(arg0, 6, b"BEERKAT", b"Beerkat On Sui", x"4d65657420426565726b61743a2074686520626c7565206d6565726b61742077686f206c6f766573206265657220616e642063727970746f2120204a6f696e20746865207061727479206173207765206272696e672066756e2c20636f6d6d756e6974792c20616e6420696e6e6f766174696f6e20746f207468652053756920436861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QSSRV_Px8fmb8_Ret_Gi_KV_Pa_Hiq_Rcv_Y_Mpm_E9_Do_D_Yvk_ZPBWY_3079b9fb1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEERKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

