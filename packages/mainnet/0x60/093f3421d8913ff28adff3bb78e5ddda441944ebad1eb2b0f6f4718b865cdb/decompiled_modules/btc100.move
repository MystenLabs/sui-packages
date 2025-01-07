module 0x60093f3421d8913ff28adff3bb78e5ddda441944ebad1eb2b0f6f4718b865cdb::btc100 {
    struct BTC100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100>(arg0, 6, b"BTC100", b"BTC100THOUSAND", x"424954434f494e20484954203130304b20484953544f52494320464f522043525950544f47524150485920204d454d4520434f494e204f4e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_m15_Y16t_QHCJ_Rp_Okgm4_Lz_Q_007bdd97dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC100>>(v1);
    }

    // decompiled from Move bytecode v6
}

