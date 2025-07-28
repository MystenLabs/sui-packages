module 0x986b2df3818ef0ffb69fd0216022538a3a1884d6226bfc8ef6472e2e2ead016e::mcvt {
    struct MCVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCVT>(arg0, 6, b"MCVT", b"Mill City Ventures III", b"Mill City Ventures III has announced a $450 million private placement to launch a corporate Sui treasury strategy. The round is led by London-based hedge fund Karatage, with a matching investment from the Sui Foundation. Other participants include Big Brain Holdings, Galaxy Digital, Pantera Capital, Electric Capital, and ParaFi Capital. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mill_city_5a6149b840.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

