module 0x81898df80a5a9a487f357f94bb5e1270acc7ce141e500d8e03355402935451ec::dpc {
    struct DPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPC>(arg0, 6, b"DPC", b"Doge pharaoh", b"Bow down, peasants, because Doge Pharaoh Coin (DPC) has arrived! This isnt just a golden dogeits the ancient ruler of riches, barking orders to your portfolio like a true crypto king. Forget pyramids; DPC is here to build your empire. With Golden Paw NFTs, a community as loyal as Doge fans and blockchain security tougher than pyramid stones, DPC is more than a coinits your ticket to royal gains. Stop digging for treasurelet Doge Pharaoh lead you to it. Doge Pharaoh Coin: where ancient bling meets modern ka-ching!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yi_Cc3yy2oqw_Fy_H8b_F_Lgh4_Y35r3_M3gsgze_For_Jf_X_Cgqvi_f77589b724.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

