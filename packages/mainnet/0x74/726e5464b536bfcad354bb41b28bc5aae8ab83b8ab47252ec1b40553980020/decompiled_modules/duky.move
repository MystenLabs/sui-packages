module 0x74726e5464b536bfcad354bb41b28bc5aae8ab83b8ab47252ec1b40553980020::duky {
    struct DUKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKY>(arg0, 6, b"DUKY", b"Duky", b"Duky is the quacktastic meme coin on the Sui Blockchain!  Embracing the fun side of crypto, Duky brings a splash of humor and community-driven growth. Join the flock and ride the wave with $DUKYbecause sometimes, its good to just go with the flow!  #Duky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_Td_Bu8_WX_400x400_8a844b4332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

