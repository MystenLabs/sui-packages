module 0xcaee026f83e2efa5ca3624b4ba5ec97fba1417819df67f5ad9ca3f9117abc199::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"Rachop", b"RachopSui", b"The Pirate Rachop Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JMI_Ld_Tcp_400x400_cd004a0004.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

