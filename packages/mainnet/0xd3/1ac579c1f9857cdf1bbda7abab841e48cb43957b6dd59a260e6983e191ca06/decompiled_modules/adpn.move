module 0xd31ac579c1f9857cdf1bbda7abab841e48cb43957b6dd59a260e6983e191ca06::adpn {
    struct ADPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADPN>(arg0, 6, b"ADPN", b"AzureWave DPN", b"Proteet onlne prvaey and monetize your unusedinternet with Decentralized VPN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pd_FG_Aock_400x400_05d0b6ae89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

